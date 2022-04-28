

// Organizing based off this: https://www.terlici.com/2014/09/29/express-router.html
//

var express = require('express');
var router = express.Router();

// Redirects to the tmp directly where ffmpeg is generating HLS videos
router.use("/video", express.static("/tmp/KitchenCam"));
router.use("/video2", express.static("/tmp/LivingRoomCam"));

module.exports = router;

