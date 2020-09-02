-- cveprov, nombre, nombrecontacto, telcontacto
CALL InsertarProveedor(1, "Bimbo", 'Juan Manuel Macias Mendez', '04451122326', 'eeorp@gmail.com');
CALL InsertarProveedor(2, "Barcel", 'Manuel Castellanos Palazuelos', '044159654845', 'eofef@gmail.com');
CALL InsertarProveedor(3, "Coca-Cola", 'Frank Ocean Reyes', '044159654845', 'eofef@gmail.com');
CALL InsertarProveedor(4, "Pepsi", 'Frank Oceans', '044159654845', 'eofef@gmail.com');
CALL InsertarProveedor(5, "Moyo", 'Antonio Montana Navas', '044154664745', 'overhere@gmail.com');

call EliminarProveedor(1);
call MostrarProveedorProductos();
call MostrarProveedorTel(1);
call EnviarProveedoresTel();


-- cveprod, nombre, tpo, precio, costo, cveprov, existencia
CALL InsertarProducto(1, "Donitas", 'Pan', 10.0, 5.0, 1, 15);
CALL InsertarProducto(2, "Mantecadas", 'Pan', 15.0, 10.0, 1, 10);
CALL InsertarProducto(3, "Pinguinos", 'Pan', 15.0, 10.0, 1, 30);
CALL InsertarProducto(4, "Ruffles", 'Frituras', 10.0, 5.0, 2, 20);
CALL InsertarProducto(5, "Takis", 'Frituras', 10.0, 6.0, 2, 2);
CALL InsertarProducto(6, "Gatorade", 'Bebida', 20.0, 13.0, 3, 14);
CALL InsertarProducto(7, "Coca-Cola 500ml", 'Bebida', 10.0, 6.0, 3, 9);
CALL InsertarProducto(8, "Pepsi 500ml", 'Bebida', 10.0, 5.5, 4, 90);

call EliminarProducto(1);
call AgregarMasProducto(1, 5);
call RestarProducto(1, 5);
call MostrarProductosAgotados();
call MostrarProductoEntre(15, 20);
call EnviarProductosAgotados();


-- noemp, nombre, appat, apmat, sueldo, %comision, tipo
CALL InsertarEmpleado(1, 'Aaron', 'Vasquez', 'del Prado', 150000.0, 4.5, 'Jefe', 'kesslertienditas@gmail.com');
call InsertarEmpleado(2, 'José Martín', 'Reyes', 'Calixto', 9000.0, 2.0, 'Vendedor', 'jojieq@gmail.com');
call InsertarEmpleado(3, 'Flavio', 'Garfias', 'Cuadrado', 9000.0, 2.0, 'Vendedor', 'peoeacm@gmail.com');
call InsertarEmpleado(4, 'Paul', 'Banks', 'Hollister', 9000.0, 2.5, 'Vendedor', 'therover@gmail.com');

call EliminarEmpleado(1);
call MostrarEmpleadoTelefonos();
call MostrarEmpleadosJefe();
call MostrarEmpleadosVendedor();
call MostrarEmpleadoSVentas();
call MostrarEmpleadoSNoVentas();
call IncrementarComision(1, 1.0);
call DecrementarComision(1, 1.0);
call MostrarEmpleadoVentasMes(1, 12);	
call MostrarEmpleadoNoVentasMes(1, '2018/12/25');	
call MostrarEmpleadoVentas(1);
call MostrarEmpleadoNoVentas(1);
call EnviarEmpleadoSVentas();


-- noemptel, telefono
call InsertarEmpleadoTel(1, '5515582569');
call InsertarEmpleadoTel(1, '5588909076');
call InsertarEmpleadoTel(2, '5531131886');
call InsertarEmpleadoTel(3, '5533143739');

call EliminarEmpleadoTel(1);


-- cveformap, descripcion
call InsertarFormaPago(1, 'Efectivo');
call InsertarFormaPago(2, 'Tarjeta de Credito');
call InsertarFormaPago(3, 'Tarjeta de Debito');
call InsertarFormaPago(4, 'Cheque');
call InsertarFormaPago(5, 'Pagare');

call EliminarFormaPago(1);


-- cvevta, subtotal, fecha, cveformap, noemp
call InsertarVenta(1, 200, '2018/12/25', 1, 1);
call InsertarVenta(2, 75, '2018/12/26', 1, 2);
call InsertarVenta(3, 150, '2018/11/15', 2, 3);

call EliminarVenta(1);
call MostrarVentaSDets();
call MostrarVentasEntre('2018/11/1', '2018/12/31');
call EnviarVentaDets();
call MostrarVentaDets(3);
call Ticket(1);

-- cvevta, nodet, cantidad, cveprod
call InsertarDetVenta(1, 1, 10, 1);
call InsertarDetVenta(1, 2, 10, 4);
call InsertarDetVenta(2, 1, 3, 2);
call InsertarDetVenta(2, 2, 2, 3);
call InsertarDetVenta(3, 1, 5, 6);
call InsertarDetVenta(3, 2, 2, 5);
call InsertarDetVenta(3, 3, 3, 7);

call EliminarDetVenta(1, 1);


-- cveclfact, nombre, direccion, rfc, correo, saldo
call InsertarClienteFact(1, 'Abraham', 'Calle 18 No.106', 'BAPJ970922', 'jamesf6888@gmail.com');
call InsertarClienteFact(2, 'Mauricio Valle Coronado', 'Av. del Pozo No.287 Col. Condesa', 'MVC880922', 'mauva@gmail.com');

call EliminarClienteFact(1);
call MostrarClienteFactCompras(1);
call MostrarClienteFactNoCompras(1);
call MostrarClienteFactComprasEntre(1, '2018/12/1', '2018/12/31');


-- cveclcdto, telefono, nombre, doctos, cvevtacdtocl, correo
call InsertarClienteCdto(1, '5597364792', 'Nacho', 'C:\Users\James\Documents\ESCOM_SEMESTRE_5\2CM4_BASES_DE_DATOS\3_UnitProyecto', 'juanjuan@gmail.com');
call InsertarClienteCdto(2, '5541364793', 'Juan Antonio Rivas Palazuelos', 'C:\Users\James\Documents\ESCOM_SEMESTRE_5\2CM4_BASES_DE_DATOS\3_UnitProyecto', 'moyodot@gmail.com');

call ElminarClienteCdto(1);
call MostrarClienteCdtoCompras(1);
call MostrarClienteCdtoNoCompras(1);
call MostrarClienteCdtoComprasEntre(1, '2018/12/1', '2018/12/31');


-- cveclenvio, nombre, nombrerec, direccion, telefono, correo
call InsertarClienteEnvio(1, 'Gerardo', 'Joshua', 'calle 17 Maravillas 106', '5515582569', 'matusalen@gmail.com');
call InsertarClienteEnvio(2, 'Carlos Salazar Irepanos', 'Sra Gabriela Mendez', 'Calle 24 No.27 Col.Maravillas', '5515512960', 'carlossi@gmail.com');

call EliminarClienteEnvio(1);
call MostrarClienteEnvioCompras(1);
call MostrarClienteEnvioNoCompras(1);
call MostrarClienteEnvioComprasEntre(1, '2018/11/1', '2018/12/31');

-- cvevtafact, cveclfact
call InsertarVtaFact(1, 1);

call EliminarVtaFact(1);


-- cvevtacdto, cveclcdto
call InsertarVtaCdto(2, 1);

call EliminarVtaCdto(1);


-- cvevtaenvio, cveclenvio
call InsertarVtaEnvio(3, 1);

call EliminarVtaEnvio(3);


-- cvevtacdtop, nopago, monto, fchlim, fchreal
call InsertarPago(2, 1, 50.0, '2018/12/21', '2018/12/22');
call InsertarPago(2, 2, 50.0, '2018/12/31', '2018/12/23');

call EliminarPago(1);


-- cvevtaenvioe, noenvio, estado, fechaposentrega, fecharealentrega
call InsertarEnvio(3, 1, 'En proceso',  '2018/12/31', '2018/12/20');
call InsertarEnvio(3, 2, 'En proceso',  '2018/12/31', '2019/1/07');
call InsertarEnvio(3, 3, 'En proceso',  '2018/12/31', '2018/12/31');

call EliminarEnvio(3, 1);

-- 61
-- ////////////////////////////////////////////////////////////PROVEEDOR
drop trigger if exists biProveedor;
delimiter #
create trigger biProveedor before insert on proveedor for each row
begin
	if(select count(*) from proveedor where nombre like new.nombre) > 0 then
		signal sqlstate '0X001' set message_text = 'El nombre de este proveedor ya esta registrado';
	end if;
end;
#
delimiter ;

drop trigger if exists biProveedor1;
delimiter #
create trigger biProveedor1 before insert on proveedor for each row
begin
	if length(new.telefonocontacto) < 10 then
		signal sqlstate '0X001' set message_text = 'El numero telefonico debe ser mayor o igual a 10 digitos';
	end if;
end;
#
delimiter ;

-- D
drop trigger if exists biProveedor2;
delimiter #
create trigger biProveedor2 before insert on proveedor for each row
begin
	if (select count(*) from proveedor where new.correocontacto like '%@%') = 0 then
		signal sqlstate '0X001' set message_text = 'Formato de correo incorrecto';
	end if;
end;
#
delimiter ;



-- ///////////////////////////////////////////////////////////PRODUCTO
drop trigger if exists biProducto;
delimiter #
create trigger biProducto before insert on producto for each row
begin
	if (new.precio <= 0 or new.costo <= 0) then
		signal sqlstate '0X001' set message_text = 'El precio ni el costo pueden ser negativos';
	end if;
end;
#
delimiter ;


drop trigger if exists biProducto1;
delimiter #
create trigger biProducto1 before insert on producto for each row
begin
	if new.precio < new.costo then
		signal sqlstate '0X001' set message_text = 'El costo no puede ser mayor al precio';
	end if;
end;
#
delimiter ;


drop trigger if exists biProducto2;
delimiter #
create trigger biProducto2 before insert on producto for each row
begin
	if new.existencia < 0 then
		signal sqlstate '0X001' set message_text = 'La existencia no puede ser menor a cero';
	end if;
end;
#
delimiter ;

-- D
drop trigger if exists buProducto;
delimiter #
create trigger buProducto before update on producto for each row
begin
	if new.existencia < 0 then
		set @mensaje = concat('No hay suficiente producto, quedan ', old.existencia);
		signal sqlstate '0X001' set message_text = @mensaje;
	end if;
end;
#
delimiter ;
	


-- ///////////////////////////////////////////////////////////EMPLEADO
drop trigger if exists biEmpleado;
delimiter #
create trigger biEmpleado before insert on empleado for each row
begin
	if new.sueldo <= 0 or new.porccom <= 0 then
		signal sqlstate '0X001' set message_text = 'El sueldo ni el porcentaje de comision pueden ser negativos o cero';
	end if;
end;
#
delimiter ;


drop trigger if exists buEmpleadoComision;
delimiter #
create trigger buEmpleadoComision before update on empleado for each row
begin
	if new.porccom <= 0 then
		signal sqlstate '0X001' set message_text = 'El porcentaje de comision no puede ser negativo o cero';
	end if;
end;
#
delimiter ;



-- //////////////////////////////////////////////////////////VENTA
drop trigger if exists biVenta;
delimiter #
create trigger biVenta before insert on venta for each row
begin
	if new.subtotal <= 0 then
		signal sqlstate '0X001' set message_text = 'El subtotal no puede ser negativo o cero';
	end if;
end;
#
delimiter ;



-- //////////////////////////////////////////////////////////DET_VTA
drop trigger if exists biDetVta;
delimiter #
create trigger biDetVta before insert on det_vta for each row
begin
	if new.cantidad <= 0 then
		signal sqlstate '0X001' set message_text = 'El subtotal ni la cantidad pueden ser negativos o cero';
	end if;
end;
#
delimiter ;



-- //////////////////////////////////////////////////////////CLIENTE_FACT
drop trigger if exists biClienteFact;
delimiter #
create trigger biClienteFact before insert on cliente_fact for each row
begin
	if (select count(*) from cliente_fact where nombre like new.nombre) > 0 then
		signal sqlstate '0X001' set message_text = 'El cliente ya ha sido registrado';
	end if;
end;
#
delimiter ;



-- ///////////////////////////////////////////////////////////CLIENTE_CDTO
drop trigger if exists biClienteCdto;
delimiter #
create trigger biClienteCdto before insert on cliente_cdto for each row
begin
	if (select count(*) from cliente_cdto where nombre like new.nombre) > 0 then
		signal sqlstate '0X001' set message_text = 'El cliente ya ha sido registrado';
	end if;
end;
#
delimiter ;

-- D
drop trigger if exists biClienteCdtoTel;
delimiter #
create trigger biClienteCdtoTel before insert on cliente_cdto for each row
begin
	if (select length(new.telefono)) < 10 then
		signal sqlstate '0X001' set message_text = 'El numero telefonico no puede ser menor de 10 digitos';
	end if;
end;
#
delimiter ;



-- //////////////////////////////////////////////////////////CLIENTE_ENVIO
drop trigger if exists biClienteEnvio;
delimiter #
create trigger biClienteEnvio before insert on cliente_envio for each row
begin
	if (select count(*) from cliente_envio where nombre like new.nombre) > 0 then
		signal sqlstate '0X001' set message_text = 'El cliente ya ha sido registrado';
	end if;
end;
#
delimiter ;

-- D
drop trigger if exists biClienteEnvioTel;
delimiter #
create trigger biClienteEnvioTel before insert on cliente_envio for each row
begin
	if (select length(new.telefono)) < 10 then
		signal sqlstate '0X001' set message_text = 'El numero telefonico no puede ser menor de 10 digitos';
	end if;
end;
#
delimiter ;



-- //////////////////////////////////////////////////////////ENVIO
drop trigger if exists biEnvioFechas;
delimiter #
create trigger biEnvioFechas before insert on envio for each row
begin
	if (select count(*) from envio where day(new.fechaposentrega) < day(new.fecharealentrega)) or (month(new.fechaposentrega) < month(new.fecharealentrega)) or (year(new.fechaposentrega) < year(new.fecharealentrega)) > 0 then
		signal sqlstate '0X001' set message_text = 'La fecha posible de entrega no puede ser antes de la fecha real de entrega';
	end if;
end;
#
delimiter ;



-- /////////////////////////////////////////////////////////////PAGO
drop trigger if exists biPago;
delimiter #
create trigger biPago before insert on pago for each row
begin
	if new.monto <= 0 then
		signal sqlstate '0X001' set message_text = 'El monto no puede ser negativo o cero';
	end if;
end;
#
delimiter ;



-- /////////////////////////////////////////////////////////////FORMA_PAGO

-- ///////////////////////////////////////////////////////////EMP_TELS
drop trigger if exists biEmpTel;
delimiter #
create trigger biEmpTel before insert on emp_tels for each row
begin
	if (select length(new.telefono)) < 10 then
		signal sqlstate '0X001' set message_text = 'El numero telefonico no puede ser menor de 10 digitos';
	end if;
end;
#
delimiter ;


-- 18