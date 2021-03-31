
function ValidacionFormularios(f)
{
	//Comproar que el nombre y el apellido del usuario solo tiene letras
	//f es el formulario
	let inputNombre = f.elements[0];
	let expr = /^[A-Z][a-z]+$/;


	if(!inputNombre.value.match(expr))
	{
		Swal.fire({
		  icon: 'error',
		  title: 'Oops...',
		  text: 'Nombre incorrecto, solo debe contener letras y empezar por mayúscula'
		})
		return false;
	}

	let inputApell = f.elements[1];

	if(!inputApell.value.match(expr))
	{
		Swal.fire({
		  icon: 'error',
		  title: 'Oops...',
		  text: 'Apellido incorrecto, solo debe contener letras y empezar por mayúscula'
		})
		return false;
	}

	let inputPais = f.elements[4];

	if(!inputPais.value.match(expr))
	{
		Swal.fire({
		  icon: 'error',
		  title: 'Oops...',
		  text: 'País/Región incorrecta, solo debe contener letras y empezar por mayúscula'
		})
		return false;
	}	


	//Selecciona la sala 
	let sel = f.elements['sel_sal'].value;

	if(sel == "")
	{
		Swal.fire({
		  icon: 'error',
		  title: 'Oops...',
		  text: 'Ninguna opción marcada, seleccione una por favor'
		})
		return false;
	}

	//Comprobar la capacidad máxima de la sala
	let nHab = f.elements['sel_nHab'].value;
	let nAdul = parseInt(f.elements['sel_adult'].value);
	let nNinos = parseInt(f.elements['sel_children'].value);

	if(sel == '1')
	{	//Es una suite Burguer, max = 4 personas
		let capMax = nHab*4;	//En cada suite caben 4 personas
		let totPerosnas = nAdul + nNinos;

		if(capMax < totPerosnas)
		{	//No caben todas las personas en las habitaciones
			Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'No caben toda las personas en la Suite Burguer'
			})
			return false;
		}
	}
	else
	{
		capMax = nHab*2;	//En cada suite caben 4 personas
		totPerosnas = nAdul + nNinos;

		if(capMax < totPerosnas)

		{	//No caben todas las personas en las habitaciones
			Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'No caben toda las personas en la Suite Macdonal'
			})
			return false;
		}
	}

	//Comprobación de las fechas
	let fInicio = f.elements['calendario_entrada'].value;
	let fFinal = f.elements['calendario_salida'].value;
	let dateIni = new Date(fInicio);
	let dateFin = new Date(fFinal);

	let today = new Date();
	let date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();

	let date_ini = dateIni.getFullYear()+'-'+(dateIni.getMonth()+1)+'-'+dateIni.getDate();
	let date_fin = dateFin.getFullYear()+'-'+(dateFin.getMonth()+1)+'-'+dateFin.getDate();

	// Se elige una fecha posterior a hoy
	if(date_ini < date)
	{
		Swal.fire({
		  icon: 'error',
		  title: 'Oops...',
		  text: 'La fecha de inicio es anterior al día de hoy'
		})
		return false;
	}
	// La fecha de inicio debe de ser menor a la salida
	if(dateIni > dateFin)
	{
		Swal.fire({
		  icon: 'error',
		  title: 'Oops...',
		  text: 'La fecha de salida debe ser posterior a la de inicio'
		})
		return false;
	}
	let hInicio = f.elements['hora_entrada'].value;
	let hFinal = f.elements['hora_salida'].value;

	// Si el día de entrada es hoy comprobar que la hora es posterior a la de ahora
	if(date_ini == date)
	{
		let time = today.getHours() + ":" + today.getMinutes();

		if(hInicio < time)
		{
			Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'La hora de inicio es anterior a la hora actual'
			})
			return false;
		}
	}
	// Si el día de entrada es el mismo que el de salida comprobar que la hora de entrada sea anterior a la de salida
	if(date_ini == date_fin)
	{
		if(hInicio > hFinal)
		{
			Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'La hora de inicio es anterior a la hora de salida'
			})
			return false;
		}
	}


	Swal.fire({
		title: 'Are you sure?',
		text: "Confirmar reserva",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Confirmar'
	}).then((result) => {
		if (result.isConfirmed) {
			Swal.fire(
			  'Reservado!',
			  'Su reserva ha sido realizada con éxito',
			  'success'
			)			
		}
	})
	alert("Reserva realizada con éxito");
}