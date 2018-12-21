
let thongbao = (noidung) => {
    let notify = $.notify({
        title: `<strong>Thông báo:</strong>`,
        message: `${noidung}`
    }, {
            type: 'success',
            allow_dismiss: true,
            delay: 2000,
            animate: {
                enter: 'animated lightSpeedIn',
                exit: 'animated lightSpeedOut'
            },
        });
}

let baoloi = (noidung) => {
    let notify = $.notify({
        title: `<strong>Thông báo:</strong>`,
        message: `${noidung}`
    }, {
            type: 'danger',
            allow_dismiss: true,
            delay: 2000,

            animate: {
                enter: 'animated lightSpeedIn',
                exit: 'animated lightSpeedOut'
            }
        });
}
let baoloimahang = () => {
    let notify = $.notify({
        title: `<strong>Thông báo:</strong>`,
        message: 'Mã hàng không tồn tại!'
    }, {
            type: 'danger',
            allow_dismiss: true,
            delay: 2000,

            animate: {
                enter: 'animated lightSpeedIn',
                exit: 'animated lightSpeedOut'
            }
        });
}
let thongbaoxoa = () => {
    let notify = $.notify({
        title: `<strong>Thông báo:</strong>`,
        message: 'Xóa thành công!'
    }, {
            type: 'success',
            allow_dismiss: true,
            delay: 2000,
            animate: {
                enter: 'animated lightSpeedIn',
                exit: 'animated lightSpeedOut'
            },
        });
}

let thongbaosua = () => {
    let notify = $.notify({
        
        title: `<strong>Thông báo:</strong>`,
        message: 'Cập nhật thành công!'
    }, {
            type: 'success',
            allow_dismiss: true,
            delay: 2000,
            animate: {
                enter: 'animated lightSpeedIn',
                exit: 'animated lightSpeedOut'
            },
        });
}
let thongbaothem = () => {
    let notify = $.notify({
       
        title: `<strong>Thông báo:</strong>`,
        message: 'Thêm mới thành công!'
    }, {
            type: 'success',
            allow_dismiss: true,
            delay: 2000,
            animate: {
                enter: 'animated lightSpeedIn',
                exit: 'animated lightSpeedOut'
            },
        });
}


function message(s, e) {
    if (s.cpUpdate) {
        delete s.cpUpdate;
        thongbaosua();
    }
    if (s.cpInsert) {
        delete s.cpInsert;
        thongbaothem();
    }
    if (s.cpDelete) {
        delete s.cpDelete;
        thongbaoxoa();
    }

}


function onToolbarItemClick(s, e) {
    switch (e.item.name) {
        case "ExportToPDF":
        case "ExportToXLSX":
        case "ExportToXLS":
            e.processOnServer = true;
            e.usePostBack = true;
            break;
    }
}

//function xacnhanthonbao(noidung,abc) {
//    $.confirm({
//        title: '<strong>Thông báo:</strong>,
//        content: noidung,
//        type: 'dak',
//        boxWidth: '25%',
//        theme: 'light',
//        autoClose: 'somethingElse|5000',
//        useBootstrap: false,
//        animation: 'zoom',
//        closeAnimation: 'scale',
//        typeAnimated: true,
//        buttons: {
            
//            tryAgain: {
//                text: 'Có',
//                btnClass: 'btn-blue',
//                keys: ['enter'],
//                action: function () {
//                      return
//
//                }
//            },
//            somethingElse: {
//                text: 'Không',
//                btnClass: 'btn-red',
//                keys: ['esc'],
//                action: function () {
//                }
//            },

//        }
//    });
//}
