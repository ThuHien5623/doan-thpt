$(function () {//kéo thả mobi
    for (var i = 1; i <= 4; i++) {
        new webkit_draggable('img' + i, { revert: 'invalid' });
    }

    webkit_drop.add("image1", {
        apect: ["img1", "img2", "img3", "img4"],
        onDrop: function (event) {

            var idText = event.id;
            switch (idText) {
                case "img1":
                    getValueBai1_Box1(1, 1);
                    break;
                    ;
                case "img2":
                    getValueBai1_Box1(1, 2);
                    break;
                    ;
                case "img3":
                    getValueBai1_Box1(1, 3);
                    break;
                    ;
                case "img4":
                    getValueBai1_Box1(1, 4);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
    webkit_drop.add("image2", {
        apect: ["img1", "img2", "img3", "img4"],
        onDrop: function (event) {

            var idText = event.id;
            switch (idText) {
                case "img1":
                    getValueBai1_Box1(2, 1);
                    break;
                    ;
                case "img2":
                    getValueBai1_Box1(2, 2);
                    break;
                    ;
                case "img3":
                    getValueBai1_Box1(2, 3);
                    break;
                    ;
                case "img4":
                    getValueBai1_Box1(2, 4);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
    webkit_drop.add("image3", {
        apect: ["img1", "img2", "img3", "img4"],
        onDrop: function (event) {

            var idText = event.id;
            switch (idText) {
                case "img1":
                    getValueBai1_Box1(3, 1);
                    break;
                    ;
                case "img2":
                    getValueBai1_Box1(3, 2);
                    break;
                    ;
                case "img3":
                    getValueBai1_Box1(3, 3);
                    break;
                    ;
                case "img4":
                    getValueBai1_Box1(3, 4);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
    webkit_drop.add("image4", {
        apect: ["img1", "img2", "img3", "img4"],
        onDrop: function (event) {

            var idText = event.id;
            switch (idText) {
                case "img1":
                    getValueBai1_Box1(4, 1);
                    break;
                    ;
                case "img2":
                    getValueBai1_Box1(4, 2);
                    break;
                    ;
                case "img3":
                    getValueBai1_Box1(4, 3);
                    break;
                    ;
                case "img4":
                    getValueBai1_Box1(4, 4);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
   
});