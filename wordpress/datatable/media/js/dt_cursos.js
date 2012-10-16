var anOpen = [];
var sImageUrl = "http://qa.kleer.la/wp-content/uploads/2011/03/";
//sImageUrl = "./DataTables-1.9.1/media/images/";

var oTable;
$(document).ready(function() {
    oTable = $('#cursos').dataTable( {
	         "aaData": aCursos,
			"bLengthChange": false,
			  "aoColumns": [
				  { "sTitle": "Comienzo", "sWidth": "6%" },
				  { "sTitle": "Descripcion", "sWidth": "58%" },
				  { "sTitle": "Lugar", "sWidth": "24%" },
				  { "sTitle": "Registro", "sClass": "right", "sWidth": "12%" }
			  ],
			"aaSorting": [],
			"bPaginate": false,
			"oLanguage": 	{
				"sProcessing":   "Procesando...",
				"sLengthMenu":   "Mostrar _MENU_ registros",
				"sZeroRecords":  "No se encontraron resultados",
				"sInfo":         "Mostrando desde _START_ hasta _END_ de _TOTAL_ registros",
				"sInfoEmpty":    "Mostrando desde 0 hasta 0 de 0 registros",
				"sInfoFiltered": "(filtrado de _MAX_ registros en total)",
				"sInfoPostFix":  "",
				"sSearch":       "Buscar:",
				"sUrl":          "",
				"oPaginate": {
					"sFirst":    "Primero",
					"sPrevious": "Anterior",
					"sNext":     "Siguiente",
					"sLast":     "Último"
				}
			}
	});
} );
