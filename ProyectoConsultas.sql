-- CADENAS
-- 1
select cveprod, producto.nombre, proveedor.nombre 
from producto
inner join proveedor using(cveprov)
where proveedor.nombre like '%Bimbo%';

on producto.cveprov = proveedor.cveprov

-- 2
select cveprov, nombrecontacto, correocontacto
from proveedor
where nombrecontacto like '%Juan Manuel%';

-- 3 
select cveprod, nombre, tipo, precio
from producto
where nombre like '%Takis%';

-- 4
select noemp, nombrepila, appat, apmat, AES_DECRYPT(correo, @cvecif)
from empleado
where appat like '%Reyes%';

-- 5
select noemp, nombrepila, appat, apmat, AES_DECRYPT(correo, @cvecif)
from empleado
where nombrepila like '%José%';

-- 6
select noemp, nombrepila, appat, apmat, AES_DECRYPT(correo, @cvecif)
from empleado
where tipo like '%Jefe%';

-- 7
select noemp, nombrepila, appat, apmat, AES_DECRYPT(correo, @cvecif)
from empleado
where tipo like '%Vendedor%';

-- 8
select cveformap, descripcion
from forma_pago
where descripcion like '%Efectivo%';

-- 9
select cveclfact, nombre
from cliente_fact
where direccion like '%18%';

-- 10
select nodet, cantidad, nombre
from det_vta, producto
where det_vta.cveprod = producto.cveprod and nombre like '%Coca-Cola%';

-- CIFRADO
-- 1
select empleado.noemp, cvevta, nombrepila, total, comision, AES_DECRYPT(correo, @cvecif)
from empleado, venta
where venta.noemp = empleado.noemp;

-- 2
select empleado.noemp, cvevta, nombrepila, total, comision, AES_DECRYPT(correo, @cvecif)
from empleado, venta
where venta.noemp = empleado.noemp and fecha between '2018/1/1' and '2018/12/31';

-- 3
select noemp, telefono, AES_DECRYPT(correo, @cvecif)
from empleado, emp_tels
where noemp = noemptel;

-- 4
select empleado.noemp, cvevta, venta.cveformap, nombrepila, AES_DECRYPT(correo, @cvecif)
from empleado, venta, forma_pago
where empleado.noemp = 1 and venta.cveformap = forma_pago.cveformap and venta.noemp = empleado.noemp; 

-- 5
select nombre, AES_DECRYPT(correo, @cvecif), cvevtafact
from cliente_fact, vta_fact
where cliente_fact.cveclfact = 1;

-- 6
select nombre, AES_DECRYPT(correo, @cvecif), count(cvevtafact) as NoCompras
from cliente_fact, vta_fact
where cliente_fact.cveclfact = 1;

-- 7
select nombre, AES_DECRYPT(correo, @cvecif), cvevtacdto
from cliente_cdto, vta_cdto
where cliente_cdto.cveclcdto = 1;

-- 8
select nombre, AES_DECRYPT(correo, @cvecif), count(cvevtacdto) as NoCompras
from cliente_cdto, vta_cdto
where cliente_cdto.cveclcdto = 1;

-- 9
select nombre, AES_DECRYPT(correo, @cvecif), cvevtaenvio
from cliente_envio, vta_envio
where cliente_envio.cveclenvio = 1;

-- 10
select nombre, AES_DECRYPT(correo, @cvecif), count(cvevtaenvio) as NoCompras
from cliente_envio, vta_envio
where cliente_envio.cveclenvio = 1;

-- FECHAS
-- 1
select *
from venta
where month(fecha) = 11;

-- 2
select *
from venta
where day(fecha) between 1 and 25;

-- 3
select * 
from pago
where year(fechalim) = 2018;

-- 4
select *
from pago
where fechalim < fechareal;

-- 5
select *
from pago
where fechalim > fechareal;

-- 6
select *
from envio
where fechaPosEntrega < fechaRealEntrega;

-- 7
select *
from envio
where fechaPosEntrega > fechaRealEntrega;

-- 8
select *
from envio
where fechaPosEntrega = fechaRealEntrega;


-- 9
select * 
from envio
where fechaRealEntrega between '2018/12/1' and '2018/12/31';

-- 10
select * 
from envio
where year(fechaRealEntrega) = 2019;

-- Tipos de JOINS
-- 1
select proveedor.nombre, producto.nombre, precio
from proveedor
left join producto using(cveprov);

-- 2
select cvevta, total, fecha, proveedor.nombre as Proveedor
from proveedor
inner join producto using(cveprov)
inner join det_vta using(cveprod)
inner join venta using(cvevta)
where month(fecha) = 11;

-- 3
select cvevta, nodet, cantidad, subtotal, cveprod, nombre
from det_vta
right join producto using (cveprod);

-- 4
select noemp, nombrepila, nombre
from empleado
inner join venta using(noemp)
inner join det_vta using(cvevta)
inner join producto using(cveprod)
where nombre like '%Mantecadas%';

-- 5
select cvevta, noemp, total, comision, nombrepila
from empleado
left join venta using(noemp);

-- 6
select cveformap, cvevta, total, fecha
from forma_pago
left join venta using(cveformap);

-- 7
select nombrepila, nombre
from empleado
inner join venta using(noemp)
inner join vta_fact on venta.cvevta = vta_fact.cvevtafact
inner join cliente_fact using(cveclfact)
where nombrepila like '%Aaron%';

-- 8
select nombre, descripcion
from cliente_fact
inner join vta_fact using(cveclfact)
inner join venta on vta_fact.cvevtafact = venta.cvevta
inner join forma_pago using(cveformap)
where nombre like '%Abraham%';

-- 9
select nombre, vta_cdto.cvevtacdto, nopago, monto
from cliente_cdto
inner join vta_cdto using(cveclcdto)
inner join pago on vta_cdto.cvevtacdto = pago.cvevtacdtop
where nombre like '%Nacho%';

-- 10
select distinct proveedor.nombre, cliente_envio.nombre
from cliente_envio
inner join vta_envio using(cveclenvio)
inner join venta on vta_envio.cvevtaenvio = venta.cvevta
inner join det_vta using(cvevta)
inner join producto using(cveprod)
inner join proveedor using(cveprov)
where cliente_envio.nombre like '%Gerardo%'; 

-- Group by, having
-- 1
select producto.cveprov, proveedor.nombre, count(producto.cveprov) as ProdxProv
from producto
inner join proveedor using(cveprov)
group by producto.cveprov;

-- 2
select producto.cveprov, proveedor.nombre, count(producto.cveprov) as ProdxProv
from producto
inner join proveedor using(cveprov)
where proveedor.nombre like '%Bimbo%' or proveedor.nombre like '%Barcel%'
group by producto.cveprov;

-- 3
select cvevta, count(*) as DetsxVta
from det_vta
group by cvevta;

-- 4
select noemp, nombrepila, count(*) as VtasxEmp
from venta
inner join empleado using(noemp)
group by noemp;

-- 5
select sueldo, count(*)
from empleado
group by sueldo;

-- 6
select porccom, count(*)
from empleado
group by porccom;

-- 7
select cveformap, descripcion, count(*)
from venta
inner join forma_pago using(cveformap)
group by cveformap;

-- 8
select producto.cveprov, proveedor.nombre, count(producto.cveprov) as ProdxProv
from producto
inner join proveedor using(cveprov)
group by producto.cveprov
having count(producto.cveprov) > 2;

-- 9
select cvevta, count(*) as DetsxVta
from det_vta
group by cvevta
having count(*) > 2;

-- 10
select noemp, nombrepila, count(*) as VtasxEmp
from venta
inner join empleado using(noemp)
group by noemp
having count(*) > 1;

