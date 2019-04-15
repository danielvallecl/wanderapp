// Focus on Login Modal
$(document).ready('#loginModal').on('shown.bs.modal', function () {
  $('#loginInput').focus()
})

// Focus on Signup Modal
$(document).ready('#signupModal').on('shown.bs.modal', function () {
  $('#signupInput').focus()
})

//Changes logo color
function logoHover() {
  document.getElementById("logo").style.color = "#1aae93"
}

function logoHoverOut() {
  document.getElementById("logo").style.color = "white"
}

// Starts a Map on the Landing Page
function initIndexMap() {
    const MAP_LAT_CENTER = 12.672496;
    const MAP_LNG_CENTER = -9.492188;
     var mapcenter = {lat: MAP_LAT_CENTER, lng: MAP_LNG_CENTER};
     var indexMap = $("#indexMap");
     var latitudes = {lat: indexMap.data('latitude')};
     var longitudes = {lng: indexMap.data('longitude')};
     var titles = indexMap.data('title');
     var ids = indexMap.data('ids');
     var address = indexMap.data('address');
     var owner = indexMap.data('owner');
     var loggedin = indexMap.data('loggedin');
     var map = new google.maps.Map(document.getElementById('indexMap'), {
       zoom: 2,
       center: mapcenter
     });

     // Adds Event Location Pins to Map
     for (var i = 0; i < latitudes['lat'].length; i++) {
       var pin = {
         url: 'assets/orangepinfull.png',
         scaledSize: new google.maps.Size(24, 38)
       }
       var geolocation = {lat: latitudes['lat'][i], lng: longitudes['lng'][i]};
       if (loggedin == true) {
         if (owner[i] == true) {
           var pin =  {
            url: 'assets/greenpinfull.png',
            scaledSize: new google.maps.Size(24, 38)
           }
         }
       }
       var marker = new google.maps.Marker({
         position: geolocation,
         map: map,
         icon: pin
      });

      if (loggedin == true) {
        showEventData(marker, "<a class=\"infowindowtitle\" href='events/" + ids[i] + "'/>" + titles[i] + "</a>" + '<br>' + address[i]);
       }
     }

     // User's location
     var userLatLng = $('#userLatLng');
     var usergeolocation = {lat: userLatLng.data('userlatitude'), lng: userLatLng.data('userlongitude')};
     var userpin = {
      url: 'assets/userpin.png',
      scaledSize: new google.maps.Size(35, 35)
     }

     var marker = new google.maps.Marker({
       position: usergeolocation,
       map: map,
       icon: userpin
     });

     var infowindow = new google.maps.InfoWindow({
       content: 'You are Here'
     });

     marker.addListener('click', function() {
        infowindow.open(map, marker);
     });

    // Centers the Map for smaller viewports
      google.maps.event.addDomListener(window, 'resize', function() {
        var center = map.getCenter()
        google.maps.event.trigger(map, "resize")
        map.setCenter(usergeolocation)
      })
}

  // Closure for InfoWindows
   function showEventData(marker, secretMessage) {
     var infowindow = new google.maps.InfoWindow({
       content: secretMessage
     });

     marker.addListener('click', function() {
       infowindow.open(marker.get('map'), marker);
     });
   }

//======== Starts a Map on the Event Show Page======

function initEventMap() {
    var eventmap = $('#eventmap');
    var eventlocation = {lat: eventmap.data('latitude'), lng: eventmap.data('longitude')};
    var map = new google.maps.Map((document.getElementById('eventmap')), {
      zoom: 14,
      center: eventlocation
    });
    var marker = new google.maps.Marker({
      position: eventlocation,
      map: map
    });

    // Adds Info Window
    var eventMapInfo = $('#eventMapInfo');
    var contentTitle = eventMapInfo.data('title');
    var contentAddress = eventMapInfo.data('address');
    var contentOwner = eventMapInfo.data('owner');

    var infowindow = new google.maps.InfoWindow({
      content: contentTitle + '</br>' + contentAddress + '</br>' + contentOwner
    });

    marker.addListener('click', function() {
        infowindow.open(map, marker);
    });

}

// Changes Button Color on Preferences Page
function changeButton(id) {
  var show = document.getElementById('demo');
  var button = document.getElementById(id);
  var x = button.classList.contains("btn-success");
  var addClass = button.classList.add("btn-success");
  var classes = button.classList;
  //show.innerHTML += button.value +" ";
  if (x === true) {
    button.classList.remove("btn-success");
  }
}

function prepare_params(){
  var button = document.getElementsByClassName('categorybutton');
  var save = document.getElementById('save');
  save.value = "["
  var first = false;
  for (var x = 0; x < button.length; x++) {
    if (button[x].classList.contains("btn-success")){
      if (first == false){
        save.value += '{"options" : ' + '"' + button[x].value + '"}';
        first = true;
    } else {
        save.value += ',{"options" : ' + '"' + button[x].value + '"}';
      }
    }
  }
  save.value += "]";
}

// Finds Preference Items
function findprefitens(buttonname){
  var button = document.getElementsByClassName('categorybutton');
  console.log (buttonname);
  for (var i = 0; i <  button.length; i++){
    if (button[i].value == buttonname){
      button[i].classList.add("btn-success");
    }
  }
}

// AJAX Request

function loadText(filename) {
  var responseJson = '';
  var xmlhandler = new XMLHttpRequest();
  console.log(xmlhandler);
  xmlhandler.onload = function() {
    if (xmlhandler.status == 200) {
      responseJson = JSON.parse(xmlhandler.responseText);
      document.getElementById("text").innerHTML = xmlhandler.responseText;
      document.getElementById("jsontarget").innerHTML = responseJson.length;
    } else if (xmlhandler.status == 404) {
        console.log("File not Found");
      }
    }
  xmlhandler.open('GET', filename, true)      /*true means asynchronous.*/
  xmlhandler.send();

  // Accessing the Json
  // console.log(responseJson['query']['results']['channel']['astronomy']['sunrise']);

}
