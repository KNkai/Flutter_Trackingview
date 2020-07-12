// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.


showInPopup = (url, title) => {
    $.ajax({
        type: "GET",
        url: url,
        success: function (res) {
            $("#form-modal .modal-body").html(res);
            $("#form-modal .modal-title").html(title);
            $("#form-modal").modal('show');
        }
    });
};

jQueryAjaxPost = form => {
    try {
        $.ajax({
            type: 'POST',
            url: form.action,
            data: new FormData(form),
            contentType: false,
            processData: false,
            success: function (res) {
                if (res.isValid) {
                    $('#view-all').html(res.html);
                    $('#form-modal .modal-body').html('');
                    $('#form-modal .modal-title').html('');
                    $('#form-modal').modal('hide');
                    $.notify('submitted successfully!', { globalPosition: 'top right', className: 'success' });
                }
                else {
                    $("#form-modal .modal-body").html(res.html);
                }
            },
            error: function (err) {
                console.log(err);
            }
        });
        return false;
    } catch (ex) {
        console.log(ex);
    }
},

jQueryAjaxDelete = form => {
    if (confirm('Are you sure to delete product?')) {
        try {
            $.ajax({
                type: 'POST',
                url: form.action,
                data: new FormData(form),
                contentType: false,
                processData: false,
                success: function (res) {
                    $('#view-all').html(res.html);
                    $.notify('delete product successfully!', { globalPosition: 'top right', className: 'success' });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        } catch (e) {
            console.log(e);
        }
    }
    return false;
    };

$("#search_trans").click(function () {
    $.ajax({
        type: 'POST',
        url: 'tracking/GetListTranByIdProduct',
        data: { id: document.getElementById("table_search").value },
        success: function (res) {
            var trHtml = '';
            $("#tr_showTrans").empty();
            $.each(res, function (i, item) {

                trHtml += '<tr><td>' + '<td>' + item.DateChecked + "-" + item.IdLocation + "-" + item.Detail + '</td>' + '<td><button data-idproduct=' + item.IdProductTransactions +' class="btn btn-info detailproduct">Detail</button></td></td>' + '</tr>';

            });
            $("#tr_showTrans").append(trHtml);
            if (res.length === 0) {
                $.notify('Have not Transactions with this id!', { globalPosition: 'top right', className: 'error' });
            } else {
                $.notify('Get transactions successfully!', { globalPosition: 'top right', className: 'success' });
            }

            $(".detailproduct").click(function (e) {
                var $target = $(e.target);
                var id = $target.data("idproduct");
                console.log("abcd");
                $.ajax({
                    type: 'GET',
                    url: 'tracking/GetProductTransById',
                    data: { id: id },
                    success: function (res) {
                        console.log(true);
                        $("#form-modal .modal-body").html(res);
                        $("#form-modal .modal-title").html("Info Product Transaction");
                        $("#form-modal").modal('show');
                    },
                    error: function (err) {
                        console.log(false);
                        console.log(err);
                    }
                })
            })
        },
        error: function (err) {
            console.log(false);
            console.log(err);
        }
    })
})



$("#search_trans").click(function () {
    $.ajax({
        type: 'POST',
        url: 'tracking/GetProductById',
        data: { id: document.getElementById("table_search").value },
        success: function (res) {
            $('#prodname').empty();
            $('#manudate').empty();
            $('#expdate').empty();
            $('#manuname').empty();
            $('#prodid').empty();

            $('#prodname').append(res.Result.NameProduct);

            $('#prodid').append(res.Result.IdProduct);

            
            $('#manudate').append(res.Result.ManufacturedDate.toString().substring(0, 10) + " " + res.Result.ManufacturedDate.toString().substring(11));

            
            $('#expdate').append(res.Result.ExpiredDate.toString().substring(0, 10) + " " + res.Result.ExpiredDate.toString().substring(11));

            
            $('#manuname').append(res.Result.Manufactured);
        },
        error: function (err) {
            console.log("sai r");
            console.log(err);
        }
    })
})