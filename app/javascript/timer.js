"use strict";

window.addEventListener('DOMContentLoaded', () => {
  const elements = document.querySelectorAll('#timer-box'),
        fullLineInMilliseconds = 7 * 24 * 60 * 60 * 1000;
  

  function getTimeRemainig(endtime) {
    let days, hours, minutes, seconds;

    const t = Date.parse(endtime) - Date.parse(new Date());

    if (t <= 0) {
        days = 0;
        hours = 0;
        minutes = 0;
        seconds = 0;
    } else {
        days = Math.floor(t / (1000 * 60 * 60 * 24));
        hours = Math.floor((t / (1000 * 60 * 60) % 24));
        minutes = Math.floor((t / 1000 / 60) % 60);
        seconds = Math.floor((t /1000) % 60);
    };
    
    return {
        'total': t,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
    };
  };

  function getZero(num) {
    if (num >= 0 && num < 10) {
      return `0${num}`;
    } else {
      return num;
    };
  };

  function setClock(selector, endtime) {
    const timer = selector,
          days = timer.querySelector('#days'),
          hours = timer.querySelector('#hours'),
          minutes = timer.querySelector('#minutes'),
          seconds = timer.querySelector('#seconds'),
          timeInterval = setInterval(updateClock, 1000);

    updateClock();

    function updateClock() {
      const t = getTimeRemainig(endtime);

      days.innerHTML = getZero(t.days);
      hours.innerHTML = getZero(t.hours);
      minutes.innerHTML = getZero(t.minutes);
      seconds.innerHTML = getZero(t.seconds);

      if (t.total <= 0) {
        clearInterval(timeInterval);
      }
    };
  };

  function changeParams(elem, width) {  
    if(width < 0) {
      elem.style.width = `100%`;
    } else if (width > fullLineInMilliseconds) {
      elem.style.width = '10%'; // Set width to 10% if greater than 7 days
    } else {
      const percentage = (width / fullLineInMilliseconds) * 100;
      elem.style.width = `${percentage}%`;
    }
  };

  elements.forEach((item) => {
    let deadline = item.querySelector('#deadline').innerHTML;
    let timer = item.querySelector('.timer');
    let progressBar = item.querySelector('.progress-bar');
    let t = Date.parse(deadline) - Date.parse(new Date());

    setClock(timer, deadline);
    changeParams(progressBar, t);
  })
});
