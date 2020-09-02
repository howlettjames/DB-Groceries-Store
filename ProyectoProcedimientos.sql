use proyecto;
set @cvecif = MD5('h4t4k3');
-- ////////////////////////////////////////////////////////////PROVEEDOR
DROP PROCEDURE IF EXISTS InsertarProveedor;
DELIMITER //
CREATE PROCEDURE InsertarProveedor(IN cveprov INT, IN nombre VARCHAR(100), IN nombrecontacto varchar(100), in telefonocontacto varchar(45), in correocontacto varchar(45))
BEGIN
	INSERT INTO proveedor VALUES(cveprov, nombre, nombrecontacto, telefonocontacto, correocontacto);
END //
DELIMITER ;


drop procedure if exists EliminarProveedor;
delimiter //
create procedure EliminarProveedor(in cveproveedor int)
begin
	delete from proveedor
	where cveprov = cveproveedor;
end //
delimiter ;


drop procedure if exists MostrarProveedorProductos;
delimiter //
create procedure MostrarProveedorProductos()
begin
	select proveedor.nombre, producto.nombre
	from proveedor, producto
	where proveedor.cveprov = producto.cveprov;
end //
delimiter ;


drop procedure if exists MostrarProveedorTel;
delimiter //
create procedure MostrarProveedorTel(in cveproveedor int)
begin
	select nombre, nombrecontacto, telefonocontacto
	from proveedor
	where cveprov = cveproveedor;
end //
delimiter ;

-- D
drop procedure if exists EnviarProveedoresTel;
delimiter //
create procedure EnviarProveedoresTel()
begin
	select nombre, nombrecontacto, telefonocontacto into outfile 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ProveedoresTel.txt'
	fields terminated by ','
	lines terminated by '\n'
	from proveedor;
end //
delimiter ;



-- ///////////////////////////////////////////////////////////PRODUCTO
DROP PROCEDURE IF EXISTS InsertarProducto;
DELIMITER //
CREATE PROCEDURE InsertarProducto(IN cveprod INT, IN nombre VARCHAR(100), IN tipo varchar(45), in precio float, in costo float, in cveprov int, in existencia int)
BEGIN
	INSERT INTO producto VALUES(cveprod, nombre, tipo, precio, costo, cveprov, existencia);
END //
DELIMITER ;


drop procedure if exists EliminarProducto;
delimiter //
create procedure EliminarProducto(in cveproducto int)
begin
	delete from producto
	where cveprod = cveproducto;
end //
delimiter ;


DROP PROCEDURE IF EXISTS AgregarMasProducto;
DELIMITER //
CREATE PROCEDURE AgregarMasProducto(IN cveproducto INT, in nueva_existencia int)
BEGIN
	update producto
	set existencia = existencia + nueva_existencia
	where cveprod = cveproducto;
END //
DELIMITER ;

--D
DROP PROCEDURE IF EXISTS MostrarProductosAgotados;
DELIMITER //
CREATE PROCEDURE MostrarProductosAgotados()
BEGIN
	select *
	from producto
	where existencia = 0;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS RestarProducto;
DELIMITER //
CREATE PROCEDURE RestarProducto(IN cveproducto INT, in resta int)
BEGIN
	update producto
	set existencia = existencia - resta
	where cveprod = cveproducto;
END //
DELIMITER ;

-- D
DROP PROCEDURE IF EXISTS MostrarProductoEntre;
DELIMITER //
CREATE PROCEDURE MostrarProductoEntre(IN preciobajo INT, in precioalto int)
BEGIN
	select cveprod, nombre, precio
	from producto
	where precio between preciobajo and precioalto;
END //
DELIMITER ;

-- D
DROP PROCEDURE IF EXISTS EnviarProductosAgotados;
DELIMITER //
CREATE PROCEDURE EnviarProductosAgotados()
BEGIN
	select * into outfile 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/ProductosAgotados.txt'
	fields terminated by ','
	lines terminated by '\n'
	from producto
	where existencia = 0;
END //
DELIMITER ;



-- //////////////////////////////////////////////////////////DET_VTA
DROP PROCEDURE IF EXISTS InsertarDetVenta;
DELIMITER //
CREATE PROCEDURE InsertarDetVenta(IN cvevta INT, IN nodet int, in cantidad int, in cveproducto int)
BEGIN
	set @subtotal = cantidad * (select precio from producto where cveprod = cveproducto);
	INSERT INTO det_vta VALUES(cvevta, nodet, cantidad, @subtotal, cveproducto);
	call RestarProducto(cveproducto, cantidad);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS EliminarDetVenta;
DELIMITER //
CREATE PROCEDURE EliminarDetVenta(IN cveventa INT, in nodeta int)
BEGIN
	delete from det_vta
	where nodet = nodeta and cvevta = cveventa;
END //
DELIMITER ;



-- //////////////////////////////////////////////////////////VENTA
DROP PROCEDURE IF EXISTS InsertarVenta;
DELIMITER //
CREATE PROCEDURE InsertarVenta(IN cvevta INT, IN subtotal float, in fecha date, in cveformap int, in noempleado int)
BEGIN
	set @total = (subtotal * 0.16) + subtotal;
	set @comision = subtotal * ((select porccom from empleado where noemp = noempleado) / 100);	
	INSERT INTO venta VALUES(cvevta, subtotal, 0.16, @total, fecha, cveformap, noempleado, @comision);
END //
DELIMITER ;


drop procedure if exists EliminarVenta;
delimiter //
create procedure EliminarVenta(in cveventa int)
begin
	delete from venta
	where cvevta = cveventa;
end //
delimiter ;


drop procedure if exists MostrarVentaSDets;
delimiter //
create procedure MostrarVentaSDets()	
begin
	select venta.cvevta, nodet, cantidad, det_vta.subtotal, producto.nombre, precio
	from venta, det_vta, producto
	where venta.cvevta = det_vta.cvevta and det_vta.cveprod = producto.cveprod;
end //
delimiter ;

-- D
drop procedure if exists EnviarVentaDets;
delimiter //
create procedure EnviarVentaDets()
begin
	select venta.cvevta, nodet, cantidad, det_vta.subtotal, producto.nombre, precio into outfile 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/VentasDetalles.txt'
	fields terminated by ','
	lines terminated by '\n'
	from venta, det_vta, producto
	where venta.cvevta = det_vta.cvevta and det_vta.cveprod = producto.cveprod;
end //
delimiter ;


DROP PROCEDURE IF EXISTS MostrarVentasEntre;
DELIMITER //
CREATE PROCEDURE MostrarVentasEntre(IN fechabajo date, in fechaalto date)
BEGIN
	select cvevta, fecha, noemp
	from venta
	where fecha between fechabajo and fechaalto;
END //
DELIMITER ;

-- D
drop procedure if exists MostrarVentaDets;
delimiter //
create procedure MostrarVentaDets(in cveventa int)
begin
	select venta.cvevta, nodet, cantidad, det_vta.subtotal, producto.nombre, precio
	from venta, det_vta, producto
	where venta.cvevta = cveventa and venta.cvevta = det_vta.cvevta and det_vta.cveprod = producto.cveprod;
end //
delimiter ;

-- D
drop procedure if exists Ticket;
delimiter //
create procedure Ticket(in cveventa int)
begin
	select venta.cvevta, nodet, fecha, cantidad, det_vta.subtotal, producto.nombre, precio, empleado.noemp, empleado.nombrepila into outfile 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Ticket.txt'
	fields terminated by ', '
	lines terminated by '\n'
	from venta, det_vta, producto, empleado
	where venta.cvevta = cveventa and venta.cvevta = det_vta.cvevta and det_vta.cveprod = producto.cveprod and venta.noemp = empleado.noemp;
end //
delimiter ;



-- ///////////////////////////////////////////////////////////EMPLEADO
DROP PROCEDURE IF EXISTS InsertarEmpleado;
DELIMITER //
CREATE PROCEDURE InsertarEmpleado(in noemp INT, IN nombrepila varchar(100), IN appat VARCHAR(100), IN apmat varchar(100), in sueldo float, in porccom float, in tipo varchar(45), in correo blob)
BEGIN
	INSERT INTO empleado VALUES(noemp, nombrepila, appat, apmat, sueldo, porccom, tipo, AES_ENCRYPT(correo, @cvecif));
END //
DELIMITER ;


drop procedure if exists EliminarEmpleado;
delimiter //
create procedure EliminarEmpleado(in noempleado int)
begin
	delete from empleado
	where noemp = noempleado;
end //
delimiter ;


DROP PROCEDURE IF EXISTS MostrarEmpleadoTelefonos;
DEL IMITER //
CREATE PROCEDURE MostrarEmpleadoTelefonos()
BEGIN
	select concat(nombrePila, ' ', appat, ' ', apmat) as Empleado, telefono
	from empleado, emp_tels
	where noemp = noemptel;
END //
DELIMITER ;

-- D
DROP PROCEDURE IF EXISTS MostrarEmpleadosJefe;
DELIMITER //
CREATE PROCEDURE MostrarEmpleadosJefe()
BEGIN
	select noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado
	from empleado
	where tipo like '%Jefe%';
END //
DELIMITER ;

-- D
DROP PROCEDURE IF EXISTS MostrarEmpleadosVendedor;
DELIMITER //
CREATE PROCEDURE MostrarEmpleadosVendedor()
BEGIN
	select noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado
	from empleado
	where tipo like '%Vendedor%';
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS MostrarEmpleadoSVentas;
DELIMITER //
CREATE PROCEDURE MostrarEmpleadoSVentas()
BEGIN
	select empleado.noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado, AES_DECRYPT(correo, @cvecif), cvevta
	from empleado, venta
	where empleado.noemp = venta.noemp;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS MostrarEmpleadoSNoVentas;
DELIMITER //
CREATE PROCEDURE MostrarEmpleadoSNoVentas()
BEGIN
	select empleado.noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado, AES_DECRYPT(correo, @cvecif), count(*) as NoVentas
	from empleado, venta
	where empleado.noemp = venta.noemp
	group by empleado.noemp;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS IncrementarComision;
DELIMITER //
CREATE PROCEDURE IncrementarComision(in noempleado int, in agregacion float)
BEGIN
	update empleado
	set porccom = porccom + agregacion
	where noemp = noempleado;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS DecrementarComision;
DELIMITER //
CREATE PROCEDURE DecrementarComision(in noempleado int, in decremento float)
BEGIN
	update empleado
	set porccom = porccom - decremento
	where noemp = noempleado;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS MostrarEmpleadoVentasMes;
DELIMITER //
CREATE PROCEDURE MostrarEmpleadoVentasMes(in noempleado int, in mesindicado int)
BEGIN
	select empleado.noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado, AES_DECRYPT(correo, @cvecif), cvevta
	from empleado
	inner join venta on empleado.noemp = venta.noemp
	where month(venta.fecha) = mesindicado and empleado.noemp = noempleado;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS MostrarEmpleadoNoVentasMes;
DELIMITER //
CREATE PROCEDURE MostrarEmpleadoNoVentasMes(in noempleado int, in mesindicado int)
BEGIN
	select empleado.noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado, AES_DECRYPT(correo, @cvecif), count(*) as NoVentas
	from empleado
	inner join venta on empleado.noemp = venta.noemp
	where month(venta.fecha) = mesindicado and empleado.noemp = noempleado;
END //
DELIMITER ;

-- D
DROP PROCEDURE IF EXISTS MostrarEmpleadoVentas;
DELIMITER //
CREATE PROCEDURE MostrarEmpleadoVentas(in noempleado int)
BEGIN
	select empleado.noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado, AES_DECRYPT(correo, @cvecif), cvevta
	from empleado, venta
	where empleado.noemp = venta.noemp and empleado.noemp = noempleado;
END //
DELIMITER ;

-- D
DROP PROCEDURE IF EXISTS MostrarEmpleadoNoVentas;
DELIMITER //
CREATE PROCEDURE MostrarEmpleadoNoVentas(in noempleado int)
BEGIN
	select empleado.noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado, AES_DECRYPT(correo, @cvecif), count(*) as NoVentas
	from empleado, venta
	where empleado.noemp = venta.noemp and empleado.noemp = noempleado
	group by empleado.noemp;
END //
DELIMITER ;

-- D
DROP PROCEDURE IF EXISTS EnviarEmpleadoSVentas;
DELIMITER //
CREATE PROCEDURE EnviarEmpleadoSVentas()
BEGIN
	select empleado.noemp, concat(nombrePila, ' ', appat, ' ', apmat) as Empleado, cvevta into outfile 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/EmpleadosVentas.txt'
	fields terminated by ','
	lines terminated by '\n'
	from empleado, venta
	where empleado.noemp = venta.noemp;
END //
DELIMITER ;


-- //////////////////////////////////////////////////////////CLIENTE_FACT
DROP PROCEDURE IF EXISTS InsertarClienteFact;
DELIMITER //
CREATE PROCEDURE InsertarClienteFact(IN cveclfact INT, IN nombre varchar(100), in direccion varchar(45), in rfc varchar(45), in correo blob)
BEGIN
	INSERT INTO cliente_fact VALUES(cveclfact, nombre, direccion, rfc, AES_ENCRYPT(correo, @cvecif));
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS EliminarClienteFact;
DELIMITER //
CREATE PROCEDURE EliminarClienteFact(IN cveclfactura INT)
BEGIN
	delete from cliente_fact
	where cveclfact = cveclfactura;
END //
DELIMITER ;


drop procedure if exists MostrarClienteFactCompras;
delimiter //
create procedure MostrarClienteFactCompras(in cveclfactura int)
begin 
	select nombre, AES_DECRYPT(correo, @cvecif), cvevtafact
	from cliente_fact, vta_fact
	where cliente_fact.cveclfact = cveclfactura;
end //
delimiter ;


drop procedure if exists MostrarClienteFactNoCompras;
delimiter //
create procedure MostrarClienteFactNoCompras(in cveclfactura int)
begin 
	select nombre, AES_DECRYPT(correo, @cvecif), count(cvevtafact) as NoCompras
	from cliente_fact, vta_fact
	where cliente_fact.cveclfact = cveclfactura;
end //
delimiter ;

-- D
DROP PROCEDURE IF EXISTS MostrarClienteFactComprasEntre;
DELIMITER //
CREATE PROCEDURE MostrarClienteFactComprasEntre(IN cveclfactura INT, in fechaabajo date, in fechaarriba date)
BEGIN
	select vta_fact.cveclfact as ClaveCliente, cliente_fact.nombre as NombreCliente, cvevtafact as ClaveVenta, venta.fecha as Fecha
	from vta_fact
	inner join cliente_fact on vta_fact.cveclfact = cliente_fact.cveclfact
	inner join venta on vta_fact.cvevtafact = venta.cvevta
	where venta.fecha between fechaabajo and fechaarriba and vta_fact.cveclfact = cveclfactura;
END //
DELIMITER ;



-- ///////////////////////////////////////////////////////////CLIENTE_CDTO
DROP PROCEDURE IF EXISTS InsertarClienteCdto;
DELIMITER //
CREATE PROCEDURE InsertarClienteCdto(IN cveclcdto INT, IN telefono varchar(45), in nombre varchar(100), in doctos varchar(100), in correo blob)
BEGIN
	INSERT INTO cliente_cdto VALUES(cveclcdto, telefono, nombre, doctos, AES_ENCRYPT(correo, @cvecif));
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS EliminarClienteCdto;
DELIMITER //
CREATE PROCEDURE EliminarClienteCdto(IN cveclcredito INT)
BEGIN
	delete from cliente_cdto
	where cveclcdto = cveclcredito;
END //
DELIMITER ;


drop procedure if exists MostrarClienteCdtoCompras;
delimiter //
create procedure MostrarClienteCdtoCompras(in cveclcdto int)
begin 
	select nombre, AES_DECRYPT(correo, @cvecif), cvevtacdto
	from cliente_cdto, vta_cdto
	where cliente_cdto.cveclcdto = cveclcdto;
end //
delimiter ;


drop procedure if exists MostrarClienteCdtoNoCompras;
delimiter //
create procedure MostrarClienteCdtoNoCompras(in cveclcdto int)
begin 
	select nombre, AES_DECRYPT(correo, @cvecif), count(cvevtacdto) as NoCompras
	from cliente_cdto, vta_cdto
	where cliente_cdto.cveclcdto = cveclcdto;
end //
delimiter ;

-- D
DROP PROCEDURE IF EXISTS MostrarClienteCdtoComprasEntre;
DELIMITER //
CREATE PROCEDURE MostrarClienteCdtoComprasEntre(IN cveclcredito INT, in fechaabajo date, in fechaarriba date)
BEGIN
	select vta_cdto.cveclcdto as ClaveCliente, cliente_cdto.nombre as NombreCliente, cvevtacdto as ClaveVenta, venta.fecha as Fecha
	from vta_cdto
	inner join cliente_cdto on vta_cdto.cveclcdto = cliente_cdto.cveclcdto
	inner join venta on vta_cdto.cvevtacdto = venta.cvevta
	where venta.fecha between fechaabajo and fechaarriba and vta_cdto.cveclcdto = cveclcredito;
END //
DELIMITER ;



-- ///////////////////////////////////////////////////////////CLIENTE_ENVIO
DROP PROCEDURE IF EXISTS InsertarClienteEnvio;
DELIMITER //
CREATE PROCEDURE InsertarClienteEnvio(IN cveclenvio INT, IN nombre varchar(100), in nombrerec varchar(100), in direccion varchar(100), in telefono varchar(45), in correo blob)
BEGIN
	INSERT INTO cliente_envio VALUES(cveclenvio, nombre, nombrerec, direccion, telefono, AES_ENCRYPT(correo, @cvecif));
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS EliminarClienteEnvio;
DELIMITER //
CREATE PROCEDURE EliminarClienteEnvio(IN cveclenvioo INT)
BEGIN
	delete from cliente_envio
	where cveclenvio = cveclenvioo;
END //
DELIMITER ;


drop procedure if exists MostrarClienteEnvioCompras;
delimiter //
create procedure MostrarClienteEnvioCompras(in cveclenvio int)
begin 
	select nombre, AES_DECRYPT(correo, @cvecif), cvevtaenvio
	from cliente_envio, vta_envio
	where cliente_envio.cveclenvio = cveclenvio;
end //
delimiter ;


drop procedure if exists MostrarClienteEnvioNoCompras;
delimiter //
create procedure MostrarClienteEnvioNoCompras(in cveclenvio int)
begin 
	select nombre, AES_DECRYPT(correo, @cvecif), count(cvevtaenvio) as NoCompras
	from cliente_envio, vta_envio
	where cliente_envio.cveclenvio = cveclenvio;
end //
delimiter ;

-- D
DROP PROCEDURE IF EXISTS MostrarClienteEnvioComprasEntre;
DELIMITER //
CREATE PROCEDURE MostrarClienteEnvioComprasEntre(IN cveclenvioo INT, in fechaabajo date, in fechaarriba date)
BEGIN
	select vta_envio.cveclenvio as ClaveCliente, cliente_envio.nombre as NombreCliente, cvevtaenvio as ClaveVenta, venta.fecha as Fecha
	from vta_envio
	inner join cliente_envio on vta_envio.cveclenvio = cliente_envio.cveclenvio
	inner join venta on vta_envio.cvevtaenvio = venta.cvevta
	where venta.fecha between fechaabajo and fechaarriba and vta_envio.cveclenvio = cveclenvioo;
END //
DELIMITER ;



-- /////////////////////////////////////////////////////////////ENVIO
DROP PROCEDURE IF EXISTS InsertarEnvio;
DELIMITER //
CREATE PROCEDURE InsertarEnvio(IN cvevtaenvioe INT, IN noenvio int, in estado varchar(45), in fechaposentrega date, in fecharealentrega date)
BEGIN
	INSERT INTO envio VALUES(cvevtaenvioe, noenvio, estado, fechaposentrega, fecharealentrega);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS EliminarEnvio;
DELIMITER //
CREATE PROCEDURE EliminarEnvio(IN cvecvtaenvioee INT, in noenvioo int)
BEGIN
	delete from envio
	where cvevtaenvioe = cvecvtaenvioee and noenvio = noenvioo;
END //
DELIMITER ;



-- /////////////////////////////////////////////////////////////PAGO
DROP PROCEDURE IF EXISTS InsertarPago;
DELIMITER //
CREATE PROCEDURE InsertarPago(IN cvevtacdtop INT, IN nopago int, in monto float, in fechalim date, in fechareal date)
BEGIN
	INSERT INTO pago VALUES(cvevtacdtop, nopago, monto, fechalim, fechareal);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS EliminarPago;
DELIMITER //
CREATE PROCEDURE EliminarPago(IN cvecvtacdtopago INT, in nopagoo int)
BEGIN
	delete from pago
	where cvevtacdtop = cvecvtacdtopago and nopago = nopagoo;
END //
DELIMITER ;



-- /////////////////////////////////////////////////////////////VTA_FACT
DROP PROCEDURE IF EXISTS InsertarVtaFact;
DELIMITER //
CREATE PROCEDURE InsertarVtaFact(in cvevtafact int, in cveclfact int)
BEGIN
	INSERT INTO vta_fact VALUES(cvevtafact, cveclfact);
END //
DELIMITER ;


drop procedure if exists EliminarVtaFact;
delimiter //
create procedure EliminarVtaFact(in cvevtafactura int)
begin
	delete from vta_fact
	where cvevtafact = cvevtafactura;
end //
delimiter ;



-- /////////////////////////////////////////////////////////////VTA_CDTO
DROP PROCEDURE IF EXISTS InsertarVtaCdto;
DELIMITER //
CREATE PROCEDURE InsertarVtaCdto(in cvevtacdto int, in cveclcdto int)
BEGIN
	INSERT INTO vta_cdto VALUES(cvevtacdto, cveclcdto);
END //
DELIMITER ;


drop procedure if exists EliminarVtaCdto;
delimiter //
create procedure EliminarVtaCdto(in cvevtacredito int)
begin
	delete from vta_cdto
	where cvevtacdto = cvevtacredito;
end //
delimiter ;



-- /////////////////////////////////////////////////////////////VTA_ENVIO
DROP PROCEDURE IF EXISTS InsertarVtaEnvio;
DELIMITER //
CREATE PROCEDURE InsertarVtaEnvio(in cvevtaenvio int, in cveclenvio int)
BEGIN
	INSERT INTO vta_envio VALUES(cvevtaenvio, cveclenvio);
END //
DELIMITER ;


drop procedure if exists EliminarVtaEnvio;
delimiter //
create procedure EliminarVtaEnvio(in cvevtaenvioo int)
begin
	delete from vta_envio
	where cvevtaenvio = cvevtaenvioo;
end //
delimiter ;



-- /////////////////////////////////////////////////////////////FORMA_PAGO
drop procedure if exists InsertarFormaPago;
delimiter //
create procedure InsertarFormaPago(in cveformap int, in descripcion varchar(100))
begin
	insert into forma_pago values(cveformap, descripcion);
end //
delimiter ;


drop procedure if exists EliminarFormaPago;
delimiter //
create procedure EliminarFormaPago(in cveformapago int)
begin
	delete from cveformap
	where cveformap = cveformapago;
end //
delimiter ;



-- ///////////////////////////////////////////////////////////EMP_TELS
DROP PROCEDURE IF EXISTS InsertarEmpleadoTel;
DELIMITER //
CREATE PROCEDURE InsertarEmpleadoTel(in noemptel int, in telefono varchar(45))
BEGIN
	INSERT INTO emp_tels VALUES(noemptel, telefono);
END //
DELIMITER ;


drop procedure if exists EliminarEmpleadoTel;
delimiter //
create procedure EliminarEmpleadoTel(in noempleadotelefono int)
begin
	delete from emp_tels
	where noemptel = noempleadotelefono;
end //
delimiter ;

