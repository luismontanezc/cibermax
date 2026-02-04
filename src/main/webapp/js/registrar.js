function establecerFechaMaxima() {
    const hoy = new Date(); // Obtiene la fecha actual
    const anioMinimo = hoy.getFullYear() - 18; // Calcula el año de hace 18 años
    const mes = hoy.getMonth(); // Obtiene el mes actual (0-11)
    
    // Establecer el último día del mes actual (se pasa al siguiente mes y se retrocede un día)
    const ultimoDiaDelMes = new Date(anioMinimo, mes + 1, 0); // El día 0 del siguiente mes es el último día del mes actual

    // Obtiene la fecha en formato YYYY-MM-DD
    const anio = ultimoDiaDelMes.getFullYear();
    const mesUltimo = String(ultimoDiaDelMes.getMonth() + 1).padStart(2, '0'); // Mes en formato 2 dígitos
    const diaUltimo = String(ultimoDiaDelMes.getDate()).padStart(2, '0'); // Día en formato 2 dígitos

    // Construye la fecha en el formato YYYY-MM-DD
    const fechaMaxima = `${anio}-${mesUltimo}-${diaUltimo}`;

    // Establece el valor máximo para el campo de fecha
    const inputFecha = document.getElementById('nacimiento');
    if (inputFecha) {
        inputFecha.setAttribute('max', fechaMaxima);
    }
}

// Asegúrate de que el DOM esté completamente cargado antes de ejecutar la función
document.addEventListener("DOMContentLoaded", function() {
    establecerFechaMaxima(); // Llama a la función cuando el DOM esté listo
});

/**
 * 
/*
function validarFormulario() {
			

			// Validar fecha de nacimiento
			const nacimiento = new Date(
					document.getElementById("nacimiento").value);
			const hoy = new Date();
			const edad = hoy.getFullYear() - nacimiento.getFullYear();
			const mes = hoy.getMonth() - nacimiento.getMonth();
			if (mes < 0 || (mes === 0 && hoy.getDate() < nacimiento.getDate())) {
				edad--;
			}
			if (edad < 18) {
				alert("Debes ser mayor de edad (+18) para registrarte.");
				return false;
			}

			// Validar número de documento según tipo
			const documento = document.getElementById("documento");
			const idDocumento = document.getElementById("iddocumento").value;
			const longitudDocumento = documento.value.length;
			if (idDocumento === "1" && longitudDocumento !== 8) {
				alert("El DNI debe tener exactamente 8 dígitos.");
				return false;
			}
			if ((idDocumento === "2" || idDocumento === "3")
					&& longitudDocumento > 20) {
				alert("El documento seleccionado debe tener un máximo de 20 dígitos.");
				return false;
			}
			
			return true;
		}
		*/
		
		
		