$(function () {
    $('.table').DataTable({
        "pageLength": 5,
        "lengthMenu": [5, 10, 15, 25, 50],
        "language": {
            search: "Buscar: ",
            lengthMenu: "Mostrar _MENU_ registros"
        }
    });
})