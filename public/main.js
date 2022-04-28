
$( document ).ready(function(){


    $(".motion >  button").on("click",function(e){
        var video = $(".motion video").first()[0];
        var url = "motion/video/out.m3u8";
        if(Hls.isSupported()) {
            var hls = new Hls();
            hls.loadSource(url);
            hls.attachMedia(video);
            hls.on(Hls.Events.MANIFEST_PARSED,function() {
                    video.play();
            });
        } else {
            video.src = url;
            //hls.attachMedia(video);
            video.play();
            
        }
        // TODO Link this to play/pause events
        setInterval(function(){
            if(video.currentTime < video.duration - 20){
                console.log("Skipped Ahead");
                video.currentTime = video.duration -10;
            }
        },5000);
    });

    $(".motion2 >  button").on("click",function(e){
        var video = $(".motion2 video").first()[0];
        var url = "motion/video2/out.m3u8";
        if(Hls.isSupported()) {
            var hls = new Hls();
            hls.loadSource(url);
            hls.attachMedia(video);
            hls.on(Hls.Events.MANIFEST_PARSED,function() {
                    video.play();
            });
        } else {
            video.src = url;
            //hls.attachMedia(video);
            video.play();
            
        }
    });

    $(".highlight >  button").on("click",function(e){
        var video = $(".highlight video").first()[0];
        var url = "motion/video/highlight.mp4?t="+Date.now();
        video.src = url;
        video.playbackRate = 2.0;

        video.play();
    });

    $(".dvr >  button").on("click",function(e){
        $.get( "dvr/"+this.name, function( data ) {} );
    });
});
