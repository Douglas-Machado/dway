// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css"

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "./vendor/some-package.js"
//
// Alternatively, you can `npm install some-package` and import
// them using a path starting with the package name:
//
//     import "some-package"
//


var driverLat = document.getElementById("driver-lat").innerText;
var driverLong = document.getElementById("driver-long").innerText;

var orderLat = document.getElementById("order-lat").innerText;
var orderLong = document.getElementById("order-long").innerText;

var deliveryLat = document.getElementById("delivery-lat").innerText;
var deliveryLong = document.getElementById("delivery-long").innerText;

var latlngs = JSON.parse(document.getElementById("polyline").innerText);

var driverIcon = L.icon({
    iconUrl: '/images/hat.png',
    iconSize: [32, 32],
    iconAnchor: [22, 35],
    popupAnchor: [-3, -76]
});

var pickupIcon = L.icon({
    iconUrl: '/images/pickup.png',
    iconSize: [32, 32],
    iconAnchor: [22, 35],
    popupAnchor: [-3, -76]
});

var deliveryIcon = L.icon({
    iconUrl: '/images/delivery.png',
    iconSize: [32, 32],
    iconAnchor: [26, 35],
    popupAnchor: [-3, -76]
});

var mymap = L.map('mapid').setView([driverLat, driverLong], 14);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png?{foo}', { foo: 'bar', attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors' }).addTo(mymap);

var polyline = L.polyline(latlngs, { color: 'red' }).addTo(mymap);

var driver_marker = L.marker([driverLat, driverLong], { icon: driverIcon }).addTo(mymap);

var order_pickup_marker = L.marker([orderLat, orderLong], { icon: pickupIcon }).addTo(mymap);

var order_delivery_marker = L.marker([deliveryLat, deliveryLong], { icon: deliveryIcon }).addTo(mymap);

mymap.fitBounds(polyline.getBounds());
