$(document).ready(function() {
  procurar_equipamento();
});

function procurar_equipamento () {
  $('#reserva_equipamento_id').change(function() {
    var id = this.value;
    $.get('/reservas/buscar?equipamento=' + id);
  });
}