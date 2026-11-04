/* ============================================================
   Garage – CEF front-end
   ------------------------------------------------------------
   Server -> UI events (sent with CEF_EmitEvent from Pawn):
     garage:begin (total, slots, premiumPoints, cash)
     garage:car   ("slot|model|name|plate|status|despawnSec|km|days|insPoints|insTax|
                    value|flags|stage|speed|boost|teleportCooldownSec|locked")  one string
     garage:end   (selectedSlot)            -1 = keep current selection
     garage:wallet(premiumPoints, cash)
     garage:toast (kind, message)           kind: 0 info, 1 success, 2 error
     garage:ask   (title, text, confirmLabel, tone)   tone: 0 normal, 1 danger, 2 premium

   UI -> server events:
     garage:ready ()
     garage:close ()
     garage:action(slot, action, arg)       action == listitem of the old "Options" dialog
     garage:confirm(yes)

   status: 0 despawned, 1 spawned, 2 occupied, 3 in garage
   flags : 1 premium, 2 rainbow, 4 VIP Plus, 8 VIP, 16 neon, 32 special neon,
           64 premium fuel, 128 confiscated, 512 special (cannot be sold)
   ============================================================ */
(() => {
'use strict';

/* ---------- Config ---------- */
const CFG = {
  imgPath: 'img/',          // optional transparent PNGs: img/<modelid>.png (falls back to a drawing)
  maxInsurance: 5,
  towPrice: 5000,
  finePrice: 5000000,
  price: { vipPlus: 500, vip: 300, rainbow: 300, resetKm: 200, resetDays: 100 },
};

/* ---------- Bridge (CEF <-> Pawn) ---------- */
const handlers = {};
const bridge = {
  on(ev, cb){
    handlers[ev] = cb;
    if (window.cef && typeof cef.on === 'function') cef.on(ev, cb);
  },
  emit(ev, ...args){
    if (window.cef && typeof cef.emit === 'function') cef.emit(ev, ...args);
    else if (window.__demoServer) window.__demoServer(ev, args);
    else console.log('[emit]', ev, args);
  },
};

/* ---------- State ---------- */
const S = {
  cars: [], slots: 0, pp: 0, cash: 0,
  selected: -1, filter: '', busy: false, modal: null, expecting: false,
};
let tnodes = new Map();   // slot -> countdown <span> in the list (cached after each list render)

/* ---------- Helpers ---------- */
const $ = (s, r = document) => r.querySelector(s);
const esc = s => String(s ?? '').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const money = n => '$' + Math.round(n).toLocaleString('en-US');
const num = n => Math.round(n).toLocaleString('en-US');
const mmss = s => { s = Math.max(0, Math.floor(s)); return String(Math.floor(s/60)).padStart(2,'0') + ':' + String(s%60).padStart(2,'0'); };
const sel = () => S.cars.find(c => c.slot === S.selected);

/* ---------- Icons ---------- */
const I = {
  power:'<path d="M12 2v10"/><path d="M18.4 6.6a9 9 0 1 1-12.8 0"/>',
  pin:'<path d="M20 10c0 6-8 12-8 12S4 16 4 10a8 8 0 1 1 16 0Z"/><circle cx="12" cy="10" r="3"/>',
  truck:'<path d="M3 6h11v10H3z"/><path d="M14 9.5h4l3 3.5v3h-7"/><circle cx="7" cy="18" r="2"/><circle cx="17" cy="18" r="2"/>',
  shield:'<path d="M12 3 4 6v6c0 5 3.5 8 8 9 4.5-1 8-4 8-9V6z"/><path d="m9 12 2 2 4-4"/>',
  undo:'<path d="M3 12a9 9 0 1 0 3-6.7L3 8"/><path d="M3 3v5h5"/>',
  dollar:'<path d="M12 2v20"/><path d="M17 6H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>',
  zap:'<path d="M13 2 3 14h9l-1 8 10-12h-9z"/>',
  crown:'<path d="m3 8 4.5 4L12 5l4.5 7L21 8l-2 11H5z"/>',
  spark:'<path d="M12 3l2.2 5.8L20 11l-5.8 2.2L12 19l-2.2-5.8L4 11l5.8-2.2z"/>',
  gauge:'<path d="m12 14 4-4"/><path d="M3.3 18a10 10 0 1 1 17.4 0"/>',
  cal:'<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18M8 3v4M16 3v4"/>',
  trash:'<path d="M4 7h16M10 11v6M14 11v6M6 7l1 13h10l1-13M9 7V4h6v3"/>',
  receipt:'<path d="M6 3h12v18l-3-2-3 2-3-2-3 2z"/><path d="M9 8h6M9 12h6"/>',
  star:'<path d="m12 3 2.7 5.6 6.1.9-4.4 4.3 1 6.1L12 17l-5.4 2.9 1-6.1L3.2 9.5l6.1-.9z"/>',
};
const icon = n => `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">${I[n]}</svg>`;

/* ---------- Vehicle drawings (fallback when img/<model>.png is missing) ---------- */
const BIKES = [448,461,462,463,468,471,481,509,510,521,522,523,581,586];
const HELIS = [417,425,447,469,487,488,497,563];
const PLANES = [460,476,511,512,513,519,520,553,577,592,593];
const BOATS = [430,446,452,453,454,472,473,484,493,595];
const SVG_OPEN = '<svg viewBox="0 0 600 260" fill="none" stroke="currentColor" stroke-width="3" stroke-linejoin="round" stroke-linecap="round">';
const SHAPES = {
  car: SVG_OPEN +
    '<path d="M48 178C48 160 62 152 92 148L176 140C204 112 244 92 296 92H372C418 92 456 112 488 142L536 150C556 154 566 166 566 184V196H48Z" fill="currentColor" fill-opacity=".08"/>' +
    '<path d="M198 140C222 116 254 104 296 104H366C402 104 432 120 456 142Z" fill="currentColor" fill-opacity=".05"/>' +
    '<path d="M318 104 322 142" opacity=".7"/><path d="M62 172H534" opacity=".3"/><path d="M540 158l18 4" /><path d="M54 166l14 2"/>' +
    '<circle cx="150" cy="198" r="38" fill="#080a0e"/><circle cx="150" cy="198" r="19"/><circle cx="150" cy="198" r="5" fill="currentColor"/>' +
    '<circle cx="466" cy="198" r="38" fill="#080a0e"/><circle cx="466" cy="198" r="19"/><circle cx="466" cy="198" r="5" fill="currentColor"/></svg>',
  bike: SVG_OPEN +
    '<circle cx="165" cy="188" r="46" fill="#080a0e"/><circle cx="165" cy="188" r="10"/><circle cx="435" cy="188" r="46" fill="#080a0e"/><circle cx="435" cy="188" r="10"/>' +
    '<path d="M165 188 232 132H340L435 188" /><path d="M232 132 214 100H258"/><path d="M340 132 372 98H412"/><path d="M270 132 300 168H350L340 132" fill="currentColor" fill-opacity=".1"/><path d="M262 124H330" stroke-width="6"/></svg>',
  heli: SVG_OPEN +
    '<ellipse cx="270" cy="150" rx="132" ry="58" fill="currentColor" fill-opacity=".08"/><path d="M394 138 540 118 550 134 402 168"/><path d="M120 78H440"/><path d="M270 92V104"/>' +
    '<path d="M170 224H390"/><path d="M215 204V224M345 204V224"/><path d="M190 140Q220 112 270 112V164H182Z" fill="currentColor" fill-opacity=".06"/><circle cx="540" cy="126" r="22" opacity=".6"/></svg>',
  plane: SVG_OPEN +
    '<path d="M50 150C120 128 440 128 548 150 440 172 120 172 50 150Z" fill="currentColor" fill-opacity=".08"/><path d="M250 148 190 62H232L336 148"/><path d="M250 152 190 238H232L336 152"/>' +
    '<path d="M72 146 48 96H92L130 144"/><path d="M470 142Q510 138 530 148"/></svg>',
  boat: SVG_OPEN +
    '<path d="M44 168H556L506 224H108Z" fill="currentColor" fill-opacity=".08"/><path d="M190 168 224 116H386L424 168"/><path d="M246 136H372" opacity=".7"/><path d="M300 116V70M300 70h40" opacity=".7"/></svg>',
};
const shapeKey = m => BIKES.includes(m) ? 'bike' : HELIS.includes(m) ? 'heli' : PLANES.includes(m) ? 'plane' : BOATS.includes(m) ? 'boat' : 'car';
// the drawings live once in a hidden sprite; every card only references them with <use> (50 cards = 50 tiny nodes instead of ~500)
document.body.insertAdjacentHTML('afterbegin',
  '<svg width="0" height="0" style="position:absolute" aria-hidden="true"><defs>' +
  Object.entries(SHAPES).map(([k, v]) => `<g id="s-${k}">${v.slice(SVG_OPEN.length, -6)}</g>`).join('') +
  '</defs></svg>');
const shapeFor = m => SVG_OPEN + `<use href="#s-${shapeKey(m)}"/></svg>`;
const imgState = new Map();   // model -> 1 image exists, 0 missing (so a missing PNG is requested only once)
const art = (model) => {
  const st = imgState.get(model), src = `${CFG.imgPath}${model}.png`;
  if (st === 0) return `<div class="art">${shapeFor(model)}</div>`;
  if (st === 1) return `<div class="art has-img"><img alt="" decoding="async" src="${src}"></div>`;
  return `<div class="art">${shapeFor(model)}<img alt="" decoding="async" loading="lazy" data-model="${model}" src="${src}"></div>`;
};
// load/error do not bubble -> listen in the capture phase
document.addEventListener('load', e => {
  const t = e.target;
  if (t.tagName === 'IMG' && t.dataset.model){ imgState.set(+t.dataset.model, 1); t.parentNode.classList.add('has-img'); }
}, true);
document.addEventListener('error', e => {
  const t = e.target;
  if (t.tagName === 'IMG' && t.dataset.model){ imgState.set(+t.dataset.model, 0); t.remove(); }
}, true);

/* ---------- Status / tags ---------- */
const STATUS = {
  0: ['despawned', 'st-despawned', 'Despawned'],
  1: ['spawned',   'st-spawned',   'Spawned'],
  2: ['occupied',  'st-occupied',  'Occupied'],
  3: ['garage',    'st-garage',    'In garage'],
};
const statusInfo = c => (c.flags & 128) && c.status === 0 ? ['confiscated','st-confiscated','Confiscated'] : (STATUS[c.status] || STATUS[0]);
const tagsFor = c => {
  const t = [];
  if (c.flags & 1)  t.push(['Premium', '#f86b33']);
  if (c.flags & 2)  t.push(['Rainbow', '#9b82ff']);
  if (c.flags & 4)  t.push(['VIP+',    '#9dff00']);
  else if (c.flags & 8) t.push(['VIP', '#ffd900']);
  if (c.stage > 0)  t.push(['Stage ' + c.stage, '#5ea5ff']);
  if (c.flags & 16) t.push(['Neon',    '#37e0ff']);
  if (c.flags & 32) t.push(['S-Neon',  '#ff4d4d']);
  if (c.flags & 64) t.push(['P-Fuel',  '#ffb84d']);
  return t;
};
const tagHtml = ([l, col]) => `<span class="tag" style="--c:${col}">${l}</span>`;

/* ---------- Rendering ---------- */
function visibleCars(){
  const f = S.filter.trim().toLowerCase();
  return !f ? S.cars : S.cars.filter(c => c.name.toLowerCase().includes(f) || c.plate.toLowerCase().includes(f));
}

function renderTop(){
  $('#slotCount').textContent = S.cars.length;
  $('#slotMax').textContent = S.slots;
  $('#slotBar').style.width = S.slots ? Math.min(100, S.cars.length / S.slots * 100) + '%' : '0';
  $('#cash').textContent = money(S.cash);
  $('#pp').textContent = num(S.pp);
}

function cardHtml(c){
  const [, cls, label] = statusInfo(c);
  const tags = tagsFor(c).slice(0, 4).map(tagHtml).join('');
  const timer = c.status !== 0 && c.despawn > 0 ? `<span data-despawn="${c.slot}">${mmss(c.despawn)}</span>` : '';
  return `<button class="card ${c.slot === S.selected ? 'active' : ''}" data-slot="${c.slot}" type="button">
      <div class="thumb">${art(c.model)}</div>
      <div>
        <div class="name">${esc(c.name)}</div>
        <div class="meta"><span class="status ${cls}">${label}</span>${timer}</div>
        ${tags ? `<div class="tags">${tags}</div>` : ''}
      </div></button>`;
}
function cacheTimers(){
  tnodes = new Map();
  document.querySelectorAll('#cards [data-despawn]').forEach(n => tnodes.set(+n.dataset.despawn, n));
}
/* redraw a single card (garage:upd) */
function updateCard(slot){
  const el = $(`.card[data-slot="${slot}"]`), c = S.cars.find(x => x.slot === slot);
  if (el && c){ el.outerHTML = cardHtml(c); cacheTimers(); }
}

function renderList(){
  const box = $('#cards'), keep = box.scrollTop;
  const list = visibleCars();
  $('#listCount').textContent = list.length;
  if (!list.length){
    box.innerHTML = `<div class="empty">${S.cars.length ? 'No vehicle matches your search.' : 'You do not own any personal vehicle yet.'}</div>`;
    tnodes = new Map();
    return;
  }
  box.innerHTML = list.map(cardHtml).join('');
  box.scrollTop = keep;
  cacheTimers();
}

function quickBtn({ action, ico, title, sub, cls = '', off = false, arg = 0 }){
  return `<button class="qbtn ${cls}" type="button" data-action="${action}" data-arg="${arg}" ${off ? 'disabled' : ''}>
    ${icon(ico)}<b>${title}</b><small>${sub}</small></button>`;
}

function renderStage(){
  const el = $('#stage'), c = sel();
  if (!c){
    el.innerHTML = `<div class="hero"><div class="empty">${S.cars.length ? 'Select a vehicle.' : 'Buy a vehicle from the dealership to see it here.'}</div></div>`;
    return;
  }
  const [, cls, label] = statusInfo(c);
  const spawned = c.status !== 0, occupied = c.status === 2, confiscated = !!(c.flags & 128);
  const vipPlus = !!(c.flags & 4);

  const stageBar = [1,2,3,4].map(i => `<i class="${i <= c.stage ? 'on' : ''}"></i>`).join('');
  const speedTxt = c.speed + (c.boost ? `<i>+${c.boost}</i>` : '') + `<i>km/h</i>`;

  const spawnBtn = spawned
    ? quickBtn({ action:1, ico:'power', title:'Despawn', sub: occupied ? 'Vehicle is occupied' : 'Put it away', cls:'stop', off: occupied })
    : quickBtn({ action:1, ico:'power', title:'Spawn', sub: confiscated ? 'Confiscated - pay the fine' : 'Bring it to the street', cls:'primary', off: confiscated });
  const tpOff = !vipPlus || !spawned || occupied || c.tp > 0;
  const tpSub = !vipPlus ? 'VIP Plus only' : !spawned ? 'Spawn it first' : c.tp > 0 ? `<span data-tp>${mmss(c.tp)}</span> cooldown` : 'Bring it to you';

  el.innerHTML = `
    <section class="hero">
      <div class="hero-head">
        <div>
          <div class="eyebrow">Selected vehicle</div>
          <h2>${esc(c.name)}</h2>
          <div class="hero-tags">${tagsFor(c).map(tagHtml).join('') || '<span class="tag" style="--c:#8e94a6">Stock</span>'}</div>
        </div>
        <div class="plate">${esc(c.plate || '------')}</div>
      </div>
      <div class="floor"></div>
      <div class="hero-art">${art(c.model)}</div>
      <div class="hero-foot">
        <div class="hero-status">
          <span class="status ${cls}">${label}</span>
          <small>${c.status !== 0 && c.despawn > 0 ? `Auto-despawn in <span data-despawn-hero>${mmss(c.despawn)}</span>` : (c.locked ? 'Locked' : 'Unlocked')}</small>
        </div>
        <div class="hero-status" style="text-align:right"><small>Vehicle value</small><b style="font-size:1.25rem">${money(c.value)}</b></div>
      </div>
    </section>

    <section class="stats">
      <div class="stat"><span>Odometer</span><b>${c.km.toLocaleString('en-US',{minimumFractionDigits:1,maximumFractionDigits:1})}<i>km</i></b></div>
      <div class="stat"><span>Days owned</span><b>${num(c.days)}<i>days</i></b></div>
      <div class="stat"><span>Insurance</span><b>${c.ins}<i>/ ${CFG.maxInsurance}</i></b><small>${money(c.insTax)} per point</small></div>
      <div class="stat"><span>Top speed</span><b>${speedTxt}</b><div class="stage-bar" title="Stage ${c.stage}/4">${stageBar}</div></div>
    </section>

    <section class="quick">
      ${spawnBtn}
      ${quickBtn({ action:3, ico:'pin',   title:'Find',    sub: spawned ? 'Mark it on the map' : 'Spawn it first', off: !spawned })}
      ${quickBtn({ action:2, ico:'truck', title:'Tow',     sub: !spawned ? 'Spawn it first' : occupied ? 'Vehicle is occupied' : `Respawn for ${money(CFG.towPrice)}`, off: !spawned || occupied || confiscated })}
      ${quickBtn({ action:5, ico:'undo',  title:'Unstuck', sub: !spawned ? 'Spawn it first' : occupied ? 'Vehicle is occupied' : 'Send to the dealership', off: !spawned || occupied })}
      ${quickBtn({ action:7, ico:'zap',   title:'Teleport',sub: tpSub, off: tpOff })}
    </section>`;
}

function act({ action, ico, title, sub, price, pcls = '', off = false, arg = 0 }){
  return `<button class="act" type="button" data-action="${action}" data-arg="${arg}" ${off ? 'disabled' : ''}>
    <span class="ico">${icon(ico)}</span>
    <span><b>${title}</b><small>${sub}</small></span>
    ${price ? `<span class="price ${pcls}">${price}</span>` : '<span></span>'}
  </button>`;
}
const ppPrice = (cost, pp) => ({ price: `${cost} PP`, pcls: pp < cost ? 'lack' : '' });

function renderSide(){
  const el = $('#side'), c = sel();
  if (!c){ el.innerHTML = ''; return; }
  const spawned = c.status !== 0, P = CFG.price;
  const isVip = !!(c.flags & 8), isVipPlus = !!(c.flags & 4), isRainbow = !!(c.flags & 2), confiscated = !!(c.flags & 128);
  const lack = cost => S.pp < cost;

  const services = [
    act({ action:4, ico:'shield', title:'Buy insurance', sub: `${c.ins}/${CFG.maxInsurance} points`, price: `${money(c.insTax)} / pt`, pcls:'cash', off: c.ins >= CFG.maxInsurance }),
    act({ action:6, ico:'dollar', title:'Sell vehicle', sub: (c.flags & 512) ? 'This vehicle cannot be sold' : 'At the dealership, inside the car', price: (c.flags & 512) ? '' : money(c.value / 2), pcls:'cash', off: !spawned || !!(c.flags & 512) }),
  ].join('');

  const premium = [
    isVipPlus
      ? act({ action:7, ico:'crown', title:'VIP Plus', sub:'2000 HP + teleport to you', price:'Owned', pcls:'owned', off:true })
      : act({ action:7, ico:'crown', title:'Upgrade to VIP Plus', sub: isVip ? '2000 HP + teleport to you' : 'Requires VIP Vehicle first', ...ppPrice(P.vipPlus, S.pp), off: !isVip || lack(P.vipPlus) }),
    isVip
      ? act({ action:8, ico:'star', title:'VIP Vehicle', sub:'Name tag on your vehicle', price:'Owned', pcls:'owned', off:true })
      : act({ action:8, ico:'star', title:'Upgrade to VIP Vehicle', sub: spawned ? 'Sit inside the vehicle' : 'Spawn it first', ...ppPrice(P.vip, S.pp), off: !spawned || lack(P.vip) }),
    isRainbow
      ? act({ action:9, ico:'spark', title:'Rainbow Vehicle', sub:'Animated rainbow paint', price:'Owned', pcls:'owned', off:true })
      : act({ action:9, ico:'spark', title:'Upgrade to Rainbow', sub: spawned ? 'Animated rainbow paint' : 'Spawn it first', ...ppPrice(P.rainbow, S.pp), off: !spawned || lack(P.rainbow) }),
    act({ action:10, ico:'gauge', title:'Reset KM', sub: `Odometer ${c.km.toFixed(1)} km`, ...ppPrice(P.resetKm, S.pp), off: !spawned || lack(P.resetKm) }),
    act({ action:11, ico:'cal',   title:'Reset days', sub: `${num(c.days)} days`, ...ppPrice(P.resetDays, S.pp), off: !spawned || lack(P.resetDays) }),
  ].join('');

  const danger = [
    act({ action:12, ico:'trash', title:'Remove tuning', sub: spawned ? 'Removes components and paintjob' : 'Spawn it first', off: !spawned }),
    confiscated ? act({ action:13, ico:'receipt', title:'Pay the fine', sub:'Confiscated for illegal parking', price: money(CFG.finePrice), pcls: S.cash < CFG.finePrice ? 'lack' : 'cash', off: S.cash < CFG.finePrice }) : '',
  ].join('');

  el.innerHTML = `
    <div class="group"><div class="group-title">${icon('shield')}Services</div>${services}</div>
    <div class="group premium"><div class="group-title">${icon('crown')}Premium upgrades</div>${premium}</div>
    <div class="group danger"><div class="group-title">${icon('trash')}Danger zone</div>${danger}</div>`;
}

function ensureSelection(){
  if (!sel() || !visibleCars().some(c => c.slot === S.selected)){
    const first = visibleCars()[0];
    S.selected = first ? first.slot : (S.cars[0] ? S.cars[0].slot : -1);
  }
}

function render(){
  ensureSelection();
  renderTop(); renderList(); renderStage(); renderSide();
}

/* highlight only (no list rebuild) */
function setActive(slot){
  const prev = $('.card.active'); if (prev) prev.classList.remove('active');
  const cur = $(`.card[data-slot="${slot}"]`); if (cur) cur.classList.add('active');
}
/* changing the selected vehicle redraws only the hero + side panel */
function selectSlot(slot){
  if (slot === S.selected) return;
  S.selected = slot;
  setActive(slot);
  renderStage(); renderSide();
}

/* countdown texts */
function refreshTimers(){
  S.cars.forEach(c => { const n = tnodes.get(c.slot); if (n) n.textContent = mmss(c.despawn); });
  const c = sel(); if (!c) return;
  const h = $('[data-despawn-hero]'); if (h) h.textContent = mmss(c.despawn);
  const t = $('[data-tp]'); if (t) t.textContent = mmss(c.tp);
}

/* ---------- Toasts ---------- */
function toast(kind, msg){
  const t = document.createElement('div');
  t.className = 'toast ' + (kind === 1 ? 'ok' : kind === 2 ? 'err' : '');
  t.textContent = msg;
  $('#toasts').appendChild(t);
  while ($('#toasts').children.length > 3) $('#toasts').firstChild.remove();
  setTimeout(() => { t.classList.add('out'); setTimeout(() => t.remove(), 260); }, 3600);
}

/* ---------- Modal ---------- */
function closeModal(){ S.modal = null; $('#modal').classList.add('hidden'); }
function openModal(html){ $('#modalCard').innerHTML = html; $('#modal').classList.remove('hidden'); }

function askConfirm({ title, text, label, tone }){
  const cls = tone === 1 ? 'danger' : tone === 2 ? 'premium' : '';
  S.modal = { type:'confirm' };
  openModal(`<h3>${esc(title)}</h3><p>${esc(text)}</p>
    <div class="modal-actions"><button type="button" data-m="no">Cancel</button><button type="button" class="go ${cls}" data-m="yes">${esc(label || 'Confirm')}</button></div>`);
}

function askInsurance(c){
  const max = CFG.maxInsurance - c.ins;
  S.modal = { type:'ins', n:1, max, tax:c.insTax, slot:c.slot };
  const draw = () => {
    const m = S.modal;
    openModal(`<h3>Buy insurance</h3>
      <p>${money(m.tax)} per insurance point. You can add up to ${m.max} more (maximum ${CFG.maxInsurance} per vehicle).</p>
      <div class="stepper"><button type="button" data-m="dec" ${m.n <= 1 ? 'disabled' : ''}>-</button><b>${m.n}</b><button type="button" data-m="inc" ${m.n >= m.max ? 'disabled' : ''}>+</button></div>
      <div class="total">Total <b>${money(m.tax * m.n)}</b></div>
      <div class="modal-actions"><button type="button" data-m="no">Cancel</button><button type="button" class="go" data-m="buy">Buy</button></div>`);
  };
  S.modal.draw = draw; draw();
}

$('#modal').addEventListener('click', e => {
  const a = e.target.closest('[data-m]')?.dataset.m;
  if (!a){ if (e.target.id === 'modal') modalNo(); return; }
  const m = S.modal; if (!m) return;
  if (a === 'yes'){ closeModal(); bridge.emit('garage:confirm', true); }
  else if (a === 'no') modalNo();
  else if (a === 'inc'){ if (m.n < m.max){ m.n++; m.draw(); } }
  else if (a === 'dec'){ if (m.n > 1){ m.n--; m.draw(); } }
  else if (a === 'buy'){ const n = m.n, slot = m.slot; closeModal(); send(slot, 4, n); }
});
function modalNo(){
  const was = S.modal; closeModal();
  if (was && was.type === 'confirm') bridge.emit('garage:confirm', false);
}

/* ---------- Actions ---------- */
function send(slot, action, arg = 0){
  if (S.busy) return;
  S.busy = true; setTimeout(() => S.busy = false, 450);
  bridge.emit('garage:action', slot, action, arg);
}

document.addEventListener('click', e => {
  const card = e.target.closest('.card');
  if (card){ selectSlot(+card.dataset.slot); return; }
  const b = e.target.closest('[data-action]');
  if (!b || b.disabled) return;
  const c = sel(); if (!c) return;
  const action = +b.dataset.action;
  if (action === 4){ askInsurance(c); return; }
  send(c.slot, action, +b.dataset.arg || 0);
});
$('#closeBtn').addEventListener('click', () => bridge.emit('garage:close'));
$('#search').addEventListener('input', e => {
  S.filter = e.target.value;
  const prev = S.selected;
  ensureSelection(); renderList();
  if (S.selected !== prev){ setActive(S.selected); renderStage(); renderSide(); }
});

document.addEventListener('keydown', e => {
  if (e.key === 'Escape'){
    e.preventDefault();
    if (S.modal) modalNo(); else bridge.emit('garage:close');
    return;
  }
  if (S.modal){
    if (e.key === 'Enter'){ e.preventDefault(); $('#modal .go')?.click(); }
    return;
  }
  if (e.key === 'ArrowDown' || e.key === 'ArrowUp'){
    e.preventDefault();
    const list = visibleCars(); if (!list.length) return;
    let i = list.findIndex(c => c.slot === S.selected);
    i = e.key === 'ArrowDown' ? Math.min(list.length - 1, i + 1) : Math.max(0, i - 1);
    selectSlot(list[i].slot);
    $('.card.active')?.scrollIntoView({ block:'nearest' });
  }
});

/* ---------- Server events ---------- */
let incoming = [];
let prevWallet = '', loaded = false;
bridge.on('garage:begin', (total, slots, pp, cash) => {
  prevWallet = S.slots + '|' + S.pp + '|' + S.cash;
  incoming = []; S.slots = slots; S.pp = pp; S.cash = cash; S.expecting = true;
});
function parseCar(rec){
  const a = String(rec).split('|');
  return {
    slot:+a[0], model:+a[1], name:a[2], plate:a[3], status:+a[4], despawn:+a[5], km:+a[6], days:+a[7],
    ins:+a[8], insTax:+a[9], value:+a[10], flags:+a[11], stage:+a[12], speed:+a[13], boost:+a[14], tp:+a[15], locked:+a[16] === 1,
    // change signature: ignores the ticking counters (only whether they are running)
    sig: a.map((v, i) => i === 5 || i === 15 ? (+v > 0 ? 1 : 0) : v).join('|'),
  };
}
// the server packs several vehicles per event, separated by ';'
bridge.on('garage:car', (chunk) => {
  String(chunk).split(';').forEach(rec => { if (rec) incoming.push(parseCar(rec)); });
});
// one vehicle + wallet after an action
bridge.on('garage:upd', (rec, pp, cash) => {
  S.busy = false;
  const c = parseCar(rec), i = S.cars.findIndex(x => x.slot === c.slot);
  if (i < 0) return;
  const old = S.cars[i], walletChanged = pp !== S.pp || cash !== S.cash;
  S.cars[i] = c; S.pp = pp; S.cash = cash;
  if (walletChanged) renderTop();
  if (old.sig !== c.sig) updateCard(c.slot);
  if (walletChanged || (c.slot === S.selected && old.sig !== c.sig)){ renderStage(); renderSide(); }
  refreshTimers();
});
// the browser is reused: the server resets the page every time /v is opened
bridge.on('garage:reset', () => {
  closeModal(); S.filter = ''; $('#search').value = ''; S.selected = -1; S.cars = []; S.busy = false;
});
bridge.on('garage:end', (selectedSlot) => {
  const old = S.cars, next = incoming, prevSel = S.selected;
  const oldSel = old.find(c => c.slot === prevSel);
  const sameList = old.length === next.length && next.every((c, i) => old[i].slot === c.slot && old[i].sig === c.sig);
  S.cars = next; S.expecting = false; S.busy = false;
  if (selectedSlot >= 0 && S.cars.some(c => c.slot === selectedSlot)) S.selected = selectedSlot;

  if (!loaded || !sameList){
    render();                                   // first load, or cars added / removed / changed
  } else {                                      // nothing changed in the list: redraw only what differs
    const walletChanged = prevWallet !== (S.slots + '|' + S.pp + '|' + S.cash);
    if (S.selected !== prevSel) setActive(S.selected);
    const cur = sel();
    if (walletChanged) renderTop();
    if (walletChanged || S.selected !== prevSel || !oldSel || !cur || oldSel.sig !== cur.sig){ renderStage(); renderSide(); }
    refreshTimers();
  }

  if (!loaded){
    loaded = true;
    const l = $('#loading'); l.classList.add('done');
    setTimeout(() => l.classList.add('hidden'), 320);   // fully remove it from rendering
  }
});
bridge.on('garage:wallet', (pp, cash) => { S.pp = pp; S.cash = cash; renderTop(); renderSide(); });
bridge.on('garage:toast', (kind, msg) => { S.busy = false; toast(kind, msg); });
bridge.on('garage:ask', (title, text, label, tone) => { S.busy = false; askConfirm({ title, text, label, tone }); });
bridge.on('cef:escape_menu', (visible) => { if (visible){ if (S.modal) modalNo(); else bridge.emit('garage:close'); } });

/* ---------- Timers (client-side countdown only) ---------- */
setInterval(() => {
  let any = false, reRender = false;
  for (const c of S.cars){
    if (c.status !== 0 && c.despawn > 0){
      c.despawn--; any = true;
      const n = tnodes.get(c.slot); if (n) n.textContent = mmss(c.despawn);
      if (c.slot === S.selected){ const h = $('[data-despawn-hero]'); if (h) h.textContent = mmss(c.despawn); }
    }
    if (c.tp > 0){
      c.tp--; any = true;
      if (c.slot === S.selected){ const t = $('[data-tp]'); if (t) t.textContent = mmss(c.tp); if (c.tp === 0) reRender = true; }
    }
  }
  if (any && reRender) renderStage();
}, 1000);

/* ---------- Boot ---------- */
window.addEventListener('DOMContentLoaded', () => {
  // Without the CEF bridge (plain browser) the demo server provides sample data.
  if (!(window.cef && cef.emit) && !window.__demoServer && /[?&]demo/.test(location.search)){
    const s = document.createElement('script'); s.src = 'demo.js'; document.head.appendChild(s);
    s.onload = () => bridge.emit('garage:ready');
    return;
  }
  bridge.emit('garage:ready');
});

window.__garage = { S, handlers };   // handy for debugging in DevTools
})();
