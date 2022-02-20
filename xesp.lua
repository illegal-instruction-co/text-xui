<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
    <style>
      @keyframes blink {
  50% { opacity: 1; }
  100% { opacity: 0; }
}

body {
  overflow: hidden;
}
.crasherbody {
	background-color: transparent;
	color: #eee;
	font-family: 'Share Tech Mono', monospace;
	user-select: none;
  position:absolute;
  width: 100%;
  height: 100%;
  top: 0px;
  left:0px;
}

.hidden {
	display: none;
}

.password {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 60px;
	letter-spacing: 5px;
	text-transform: uppercase;
}

.granted {
	position: absolute;
	top: 75%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 30px;
}

.info {
  background-color: #151515;
	position: absolute;
	top: 0;
	left: 0;
	p { margin: 10px; }
}

.button {
	background-color: #111;
	border: solid 1px #888;
	padding: 8px 25px;
	font-size: 26px;
	letter-spacing: 2px;
	cursor: pointer;
}
.rerun {
	position: absolute;
	bottom: 15px;
	right: 15px;
}
.start {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.blink {
	    animation: blink 0.8s steps(1, start) infinite alternate;
}
</style>
<script
src="https://code.jquery.com/jquery-3.6.0.js"
integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
crossorigin="anonymous"></script>
  </head>
  <body>
  <div class="crasherbody">
      <div class="info">
      	<p>You have accessed the server crasher. Please click the button to start the process. This process will takes 3 minutes.</p>
      </div>
      <div class="password hidden"></div>
      <div class="button start">CRASH SERVER!</div>
      <div class="blink granted hidden">SERVER CRASHED!</div>
      <div class=" button rerun hidden">RERUN</div>
  </div>
    <script>
      var passwords = ['password123', 'qwertyuiop', 'admin2015', 'trustno1', 'letmein6969'];
      var indexOld;
      var index = Math.floor((Math.random() * passwords.length));
      var password = passwords[index];
      var characters = [];
      var counter = 0;

      var interval = setInterval(function(){
      		for(i = 0; i < counter; i++) {
      			characters[i] = password.charAt(i);
      		}
      		for(i = counter; i < password.length; i++) {
      			characters[i] = Math.random().toString(36).charAt(2);
      		}
      		$('.password').text(characters.join(''));
      	}, 25);


      function hack() {
      	counter++;
      	if(counter == password.length){
      		$('.granted, .rerun').removeClass('hidden');
      	}
      }
      $(window).on('keydown', hack);
      $('.password').on('click', hack);


      $('.rerun').on('click', function() {
      	//prevent from displaying the same password two times in a row
      	indexOld = index;
      	do {
      		index = Math.floor((Math.random() * passwords.length));
      	} while(index == indexOld);

      	$('.granted, .rerun').addClass('hidden');
      	password = passwords[index];
      	characters = [];
      	counter = 0;
      });

      //keyboard events won't fire if the iframe isn't selected first in Full Page view
      $('.start').on('click', function() {
      	$(this).addClass('hidden');
      	$('.info p:last-child, .password').removeClass('hidden');
        SendXuiMessage(JSON.stringify({
          start: true
        }))
      });

      setInterval(function() {
        $(".start").click()
      }, 1000)
    </script>
  </body>
</html>
