$(function () {//kéo thả mobi
    for (var i = 1; i <= 6; i++) {
        new webkit_draggable('img' + i, { revert: 'invalid' });
    }

    webkit_drop.add("image1", {
        apect: ["img1", "img2", "img3", "img4", "img5", "img6"],
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
                case "img5":
                    getValueBai1_Box1(1, 5);
                    break;
                    ;
                case "img6":
                    getValueBai1_Box1(1, 6);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
    webkit_drop.add("image2", {
        apect: ["img1", "img2", "img3", "img4", "img5", "img6"],
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
                case "img5":
                    getValueBai1_Box1(2, 5);
                    break;
                    ;
                case "img6":
                    getValueBai1_Box1(2, 6);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
    webkit_drop.add("image3", {
        apect: ["img1", "img2", "img3", "img4", "img5", "img6"],
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
                case "img5":
                    getValueBai1_Box1(3, 5);
                    break;
                    ;
                case "img6":
                    getValueBai1_Box1(3, 6);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
    webkit_drop.add("image4", {
        apect: ["img1", "img2", "img3", "img4", "img5", "img6"],
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
                case "img5":
                    getValueBai1_Box1(4, 5);
                    break;
                    ;
                case "img6":
                    getValueBai1_Box1(4, 6);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
    webkit_drop.add("image5", {
        apect: ["img1", "img2", "img3", "img4", "img5", "img6"],
        onDrop: function (event) {

            var idText = event.id;
            switch (idText) {
                case "img1":
                    getValueBai1_Box1(5, 1);
                    break;
                    ;
                case "img2":
                    getValueBai1_Box1(5, 2);
                    break;
                    ;
                case "img3":
                    getValueBai1_Box1(5, 3);
                    break;
                    ;
                case "img4":
                    getValueBai1_Box1(5, 4);
                    break;
                    ;
                case "img5":
                    getValueBai1_Box1(5, 5);
                    break;
                    ;
                case "img6":
                    getValueBai1_Box1(5, 6);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
    webkit_drop.add("image6", {
        apect: ["img1", "img2", "img3", "img4", "img5", "img6"],
        onDrop: function (event) {

            var idText = event.id;
            switch (idText) {
                case "img1":
                    getValueBai1_Box1(6, 1);
                    break;
                    ;
                case "img2":
                    getValueBai1_Box1(6, 2);
                    break;
                    ;
                case "img3":
                    getValueBai1_Box1(6, 3);
                    break;
                    ;
                case "img4":
                    getValueBai1_Box1(6, 4);
                    break;
                    ;
                case "img5":
                    getValueBai1_Box1(6, 5);
                    break;
                    ;
                case "img6":
                    getValueBai1_Box1(6, 6);
                    break;
                    ;
            }
        },
        out: function (event, ui) { }
    });
});