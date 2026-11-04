/* Demo "server" – only used when index.html is opened in a normal browser with ?demo
   (e.g. file:///.../index.html?demo). Not needed in-game; you can delete it. */
(() => {
  let pp = 640, cash = 1250000;
  const cars = [
    { slot:0, model:560, name:'Sultan',  plate:'PS-777', status:1, despawn:540, km:1280.4, days:41, ins:2, insTax:12000, value:185000, flags:1|2|8,  stage:3, speed:215, boost:85, tp:0,  locked:0 },
    { slot:1, model:411, name:'Infernus',plate:'RS-001', status:0, despawn:0,   km:312.8,  days:9,  ins:5, insTax:25000, value:480000, flags:4|8|16, stage:4, speed:240, boost:85, tp:0,  locked:0 },
    { slot:2, model:521, name:'FCR-900', plate:'BK-420', status:2, despawn:0,   km:88.1,   days:3,  ins:0, insTax:6000,  value:62000,  flags:0,      stage:0, speed:175, boost:0,  tp:0,  locked:1 },
    { slot:3, model:487, name:'Maverick',plate:'HE-212', status:0, despawn:0,   km:40.0,   days:120,ins:1, insTax:40000, value:900000, flags:128,    stage:0, speed:160, boost:0,  tp:0,  locked:0 },
    { slot:4, model:429, name:'Banshee', plate:'XX-009', status:3, despawn:0,   km:2210.9, days:77, ins:3, insTax:15000, value:210000, flags:32|64,  stage:2, speed:200, boost:35, tp:0,  locked:0 },
  ];
  let pending = null;
  const to = (ev, ...a) => setTimeout(() => window.__garage.handlers[ev](...a), 30);
  const sync = (sel = -1) => {
    to('garage:begin', cars.length, 13, pp, cash);
    cars.forEach(c => to('garage:car', [c.slot, c.model, c.name, c.plate, c.status, c.despawn, c.km, c.days, c.ins, c.insTax, c.value, c.flags, c.stage, c.speed, c.boost, c.tp, c.locked].join('|')));
    to('garage:end', sel);
  };
  const err = m => to('garage:toast', 2, m);
  const ok  = m => to('garage:toast', 1, m);

  window.__demoServer = (ev, a) => {
    if (ev === 'garage:ready') return sync();
    if (ev === 'garage:close') return console.log('[server] close');
    if (ev === 'garage:confirm'){ if (a[0] && pending) pending(); pending = null; return; }
    if (ev !== 'garage:action') return;
    const [slot, act, arg] = a, c = cars.find(x => x.slot === slot);
    const need = () => c.status === 0 && (err('Eroare: Vehiculul tau nu este spawnat!'), true);
    switch (act){
      case 1:
        if (c.status === 0){ c.status = 1; c.despawn = 600; ok('Your ' + c.name + ' has been spawned.'); }
        else if (c.status === 2) return err('Eroare: Vehiculul tau este ocupat!');
        else { c.status = 0; c.despawn = 0; ok('Your ' + c.name + ' has been despawned.'); }
        return sync(slot);
      case 2: if (need()) return; cash -= 5000; c.despawn = 600; ok('Your ' + c.name + ' has been respawned.'); return sync(slot);
      case 3: if (need()) return; return ok('Mergi la punctul rosu de pe minimap pentru a ajunge la masina ta.');
      case 4: cash -= c.insTax * arg; c.ins += arg; ok('Ai platit $' + c.insTax * arg + ' pentru ' + arg + ' puncte asigurare.'); return sync(slot);
      case 5: if (need()) return; return ok('Checkpoint marked at the location.');
      case 8:
        if (need()) return;
        to('garage:ask', 'Upgrade to VIP Vehicle', 'Are you sure you want to do this?\nIt costs 300 Premium Points.', 'Upgrade', 2);
        pending = () => { pp -= 300; c.flags |= 8; ok('Felicitari! Ti-ai upgradat vehiculul la unul VIP.'); sync(slot); }; return;
      case 9:
        if (need()) return;
        to('garage:ask', 'Upgrade to Rainbow', 'Are you sure you want to do this?\nIt costs 300 Premium Points.', 'Upgrade', 2);
        pending = () => { pp -= 300; c.flags |= 2; ok('Felicitari! Ti-ai upgradat vehiculul la unul RainBow.'); sync(slot); }; return;
      case 12:
        if (need()) return;
        to('garage:ask', 'Remove tuning', 'All components and the paintjob will be removed.\nThis cannot be undone.', 'Remove', 1);
        pending = () => { ok('Tunning was successfully deleted!'); }; return;
      default: return err('Demo: action ' + act + ' is not simulated.');
    }
  };
})();
