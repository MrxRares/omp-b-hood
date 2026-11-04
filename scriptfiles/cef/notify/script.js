'use strict';

const MAX_NOTIFICATIONS = 3;

function addNotification(type, title, message, duration = 4000) {
    const container = document.getElementById('notification-container');
    if (!container) return;

    while (container.children.length >= MAX_NOTIFICATIONS) {
        container.removeChild(container.firstElementChild);
    }

    const notif = document.createElement('div');
    notif.className = `notification ${type}`;

    let iconSymbol = '⚡';
    switch (type) {
        case 'admin': iconSymbol = '⭐'; break;
        case 'money_plus': iconSymbol = '$'; break;
        case 'error': iconSymbol = '⚠️'; break;
        case 'announcement': iconSymbol = 'ℹ️'; break;
        case 'event': iconSymbol = '🎁'; break;
    }

    notif.innerHTML = `
        <div class="notif-icon-box">${iconSymbol}</div>
        <div class="notif-content">
            <div class="notif-title">${escapeHtml(title)}</div>
            <div class="notif-text">${escapeHtml(message)}</div>
        </div>
        <button class="notif-close" aria-label="Închide">&times;</button>
        <div class="notif-progress-container">
            <div class="notif-progress-bar"></div>
        </div>
    `;

    const closeBtn = notif.querySelector('.notif-close');
    const progressBar = notif.querySelector('.notif-progress-bar');
    let isRemoved = false;
    let hideTimeout;

    const removeNotification = () => {
        if (isRemoved) return;
        isRemoved = true;
        notif.classList.remove('show');
        notif.classList.add('hide');
        setTimeout(() => {
            if (notif.parentNode) notif.remove();
        }, 150);
    };

    closeBtn.addEventListener('click', removeNotification, { once: true });

    // Pornim timerul de închidere
    hideTimeout = setTimeout(removeNotification, duration);

    // Oprire / Pauză la hover (inclusiv pentru bara de progres)
    notif.addEventListener('mouseenter', () => {
        clearTimeout(hideTimeout);
        if (progressBar) {
            const computedWidth = window.getComputedStyle(progressBar).width;
            progressBar.style.transition = 'none';
            progressBar.style.width = computedWidth;
        }
    });

    notif.addEventListener('mouseleave', () => {
        if (progressBar) {
            progressBar.style.transition = `width 2000ms linear`;
            progressBar.style.width = '0%';
        }
        hideTimeout = setTimeout(removeNotification, 2000);
    });

    container.appendChild(notif);

    // Randare instantanee pe GPU și declanșare animație bară fără lag
    requestAnimationFrame(() => {
        notif.classList.add('show');
        if (progressBar) {
            progressBar.style.transition = `width ${duration}ms linear`;
            progressBar.style.width = '0%';
        }
    });
}

function escapeHtml(str) {
    return str.replace(/[&<>'"]/g, 
        tag => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', "'": '&#39;', '"': '&quot;' }[tag] || tag)
    );
}

document.addEventListener("DOMContentLoaded", () => {
    if (typeof cef !== 'undefined') {
        cef.on("showNotification", (type, title, message, duration) => {
            addNotification(type, title, message, duration);
        });
    } else if (typeof window !== 'undefined') {
        window.showNotification = (type, title, message, duration) => {
            addNotification(type, title, message, duration);
        };
    }
});