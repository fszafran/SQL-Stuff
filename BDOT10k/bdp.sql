
--extends
CREATE EXTENSION postgis;

--lookups
create table OT_ZrodloDanych (
    id serial primary key,
    nazwa text not null
);
create table OT_KatIstnienia (
    id serial primary key,
    nazwa text not null
);
create table OT_RodzajRzeki (
    id serial primary key,
    nazwa text not null
);
create table OT_StatusEksploatacji (
    id serial primary key,
    nazwa text not null
);
create table OT_PrzebiegCieku (
    id serial primary key,
    nazwa text not null
);
create table OT_RodzajRepGeom (
	id serial primary key,
	nazwa text not null
);
create table OT_PolozenieCieku (
	id serial primary key,
	nazwa text not null
);

insert into OT_ZrodloDanych(nazwa) values 
('EGiB'),
('GESUT'),
('PRG'),
('ortofotomapa'),
('BDOT500'),
('mapa zasadnicza'),
('mapa topograficzna 10k'),
('NMT'),
('centralny rejestr form ochrony przyrody'),
('pomiar terenowy'),
('inne');
insert into OT_KatIstnienia(nazwa) values 
('eksploatowany'),
('w budowie'),
('zniszczony'),
('nieczynny');
insert into OT_RodzajRzeki(nazwa) values 
('rzeka'),
('strumień, potok lub struga');
insert into OT_StatusEksploatacji(nazwa) values 
('nieżeglowny'),
('żeglowny');
insert into OT_PrzebiegCieku(nazwa) values 
('ciek główny'),
('ramię boczne');
insert into OT_RodzajRepGeom(nazwa) values 
('sztuczny łącznik');
insert into OT_PolozenieCieku(nazwa) values 
('na powierzchni'),
('pod powierzchnią'),
('nad powierzchnią');


--tables

-- abstract class 

-- create table OT_ObiektTopograficzny(
-- 	lokalnyId text not null primary key,
-- 	przestrzenNazw text not null,
-- 	wersja timestamp not null,
-- 	poczatekWersjiObiektu timestamp not null,
-- 	koniecWersjiObiektu timestamp,
-- 	oznaczenieZmiany text not null,
-- 	zrodloDanychGeometrycznych integer references OT_ZrodloDanych(id) not null,
-- 	kategoriaIstnienia integer references OT_KatIstnienia(id),
-- 	uwagi text,
-- 	informacjaDodatkowa text,
-- 	kodKarto10k text,
-- 	kodKarto250k text,
-- 	skrotKartograficzny text
-- );

-- abstract class

-- create table OT_SiecWodna(
-- 	lokalnyId text not null primary key,
-- 	przestrzenNazw text not null,
-- 	wersja timestamp not null,
-- 	poczatekWersjiObiektu timestamp not null,
-- 	koniecWersjiObiektu timestamp,
-- 	oznaczenieZmiany text not null,
-- 	zrodloDanychGeometrycznych integer references OT_ZrodloDanych(id) not null,
-- 	kategoriaIstnienia integer references OT_KatIstnienia(id),
-- 	uwagi text,
-- 	informacjaDodatkowa text,
-- 	kodKarto10k text,
-- 	kodKarto250k text,
-- 	skrotKartograficzny text,
-- 	identyfikatorPRNG text,
-- 	polozenie integer references OT_PolozenieCieku(id),
-- 	szerokosc decimal check (szerokosc >=0),
-- 	nazwa text,
-- 	geometria GEOMETRY(LINESTRING,2180) not null	
-- );

create table OT_SWRS_L(
	lokalnyId text not null primary key,
	przestrzenNazw text not null,
	wersja timestamp not null,
	poczatekWersjiObiektu timestamp not null,
	koniecWersjiObiektu timestamp,
	oznaczenieZmiany text not null,
	zrodloDanychGeometrycznych integer references OT_ZrodloDanych(id) not null,
	kategoriaIstnienia integer references OT_KatIstnienia(id),
	uwagi text,
	informacjaDodatkowa text,
	kodKarto10k text,
	kodKarto250k text,
	skrotKartograficzny text,
	identyfikatorPRNG text,
	polozenie integer references OT_PolozenieCieku(id),
	szerokosc decimal check (szerokosc >=0),
	nazwa text,
	geometria GEOMETRY(LINESTRING,2180) not null,
	rodzaj integer references OT_RodzajRzeki(id) not null,
	statusEksploatacji integer references OT_StatusEksploatacji(id) not null,
	przebieg integer references OT_PrzebiegCieku(id),
	cechaGeometrii integer references OT_RodzajRepGeom(id),
	identyfikatorMPHP text
);

create table OT_SWKN_L(
	lokalnyId text not null primary key,
	przestrzenNazw text not null,
	wersja timestamp not null,
	poczatekWersjiObiektu timestamp not null,
	koniecWersjiObiektu timestamp,
	oznaczenieZmiany text not null,
	zrodloDanychGeometrycznych integer references OT_ZrodloDanych(id) not null,
	kategoriaIstnienia integer references OT_KatIstnienia(id),
	uwagi text,
	informacjaDodatkowa text,
	kodKarto10k text,
	kodKarto250k text,
	skrotKartograficzny text,
	identyfikatorPRNG text,
	polozenie integer references OT_PolozenieCieku(id),
	szerokosc decimal check (szerokosc >=0),
	nazwa text,
	geometria GEOMETRY(LINESTRING,2180) not null,
	statusEksploatacji integer references OT_StatusEksploatacji(id) not null,
	cechaGeometrii integer references OT_RodzajRepGeom(id),
	identyfikatorMPHP text
);
create table OT_ReferencjaDoObiektu(
	lokalnyId text primary key not null,
	przestrzenNazw text not null
);

create table OT_SWRM_L(
	lokalnyId text not null primary key,
	przestrzenNazw text not null,
	wersja timestamp not null,
	poczatekWersjiObiektu timestamp not null,
	koniecWersjiObiektu timestamp,
	oznaczenieZmiany text not null,
	zrodloDanychGeometrycznych integer references OT_ZrodloDanych(id) not null,
	kategoriaIstnienia integer references OT_KatIstnienia(id),
	uwagi text,
	informacjaDodatkowa text,
	kodKarto10k text,
	kodKarto250k text,
	skrotKartograficzny text,
	identyfikatorPRNG text,
	polozenie integer references OT_PolozenieCieku(id),
	szerokosc decimal check (szerokosc >=0),
	nazwa text,
	geometria GEOMETRY(LINESTRING,2180) not null,
	OT_ReferencjaDoObiektu_id text references OT_ReferencjaDoObiektu(lokalnyId)
);

--obiekt topograficzny indexes
--indexes on primary keys are commented out, because according to postgresql documentation they are created automatically

--create index idx_ot_obiekttopograficzny_localnyid on OT_ObiektTopograficzny using btree(localnyId);
create index idx_ot_obiekttopograficzny_zrodlo on OT_ObiektTopograficzny(zrodloDanychGeometrycznych);
create index idx_ot_obiekttopograficzny_kategoria on OT_ObiektTopograficzny(kategoriaIstnienia);

--siec wodna indexes
--create index idx_ot_siecwodna_localnyid on OT_SiecWodna using btree(localnyId);
create index idx_ot_siecwodna_geometria on OT_SiecWodna using gist(geometria);
create index idx_ot_siecwodna_zrodlo on OT_SiecWodna(zrodloDanychGeometrycznych);
create index idx_ot_siecwodna_kategoria on OT_SiecWodna(kategoriaIstnienia);
create index idx_ot_siecwodna_polozenie on OT_SiecWodna(polozenie);

--swrs_l indexes
--create index idx_ot_swrs_l_localnyid on OT_SWRS_L using btree(localnyId);
create index idx_ot_swrs_l_zrodlo on OT_SWRS_L(zrodloDanychGeometrycznych);
create index idx_ot_swrs_l_kategoria on OT_SWRS_L(kategoriaIstnienia);
create index idx_ot_swrs_l_polozenie on OT_SWRS_L(polozenie);
create index idx_ot_swrs_l_status on OT_SWRS_L(statusEksploatacji);
create index idx_ot_swrs_l_przebieg on OT_SWRS_L(przebieg);
create index idx_ot_swrs_l_cecha on OT_SWRS_L(cechaGeometrii);
create index idx_ot_swrs_l_geom on OT_SWRS_L using gist(geometria);

--swkn_l indexes
--create index idx_ot_swkn_l_localnyid on OT_SWKN_L using btree(localnyId);
create index idx_ot_swkn_l_zrodlo on OT_SWKN_L(zrodloDanychGeometrycznych);
create index idx_ot_swkn_l_kategoria on OT_SWKN_L(kategoriaIstnienia);
create index idx_ot_swkn_l_polozenie on OT_SWKN_L(polozenie);
create index idx_ot_swkn_l_status on OT_SWKN_L(statusEksploatacji);
create index idx_ot_swkn_l_cecha on OT_SWKN_L(cechaGeometrii);
create index idx_ot_swkn_l_geom on OT_SWKN_L using gist(geometria);

--swrm_l indexes
--create index idx_ot_swrm_l_localnyid on OT_SWRM_L using btree(localnyId);
create index idx_ot_swrm_l_fk on OT_SWRM_L(OT_ReferencjaDoObiektu_id);
create index idx_ot_swrm_l_zrodlo on OT_SWRM_L(zrodloDanychGeometrycznych);
create index idx_ot_swrm_l_kategoria on OT_SWRM_L(kategoriaIstnienia);
create index idx_ot_swrm_l_polozenie on OT_SWRM_L(polozenie);
create index idx_ot_swrm_l_geom on OT_SWRM_L using gist(geometria);

-- mv swrs
create materialized view mv_ot_swrs_l as
select rs.lokalnyId, rs.wersja, rs.geometria, rs.nazwa, rs.szerokosc, zd.nazwa as zrodloDanychGeometrycznych,
kt.nazwa as kategoriaIstnienia, pc.nazwa as polozenie, se.nazwa as statusEksploatacji, rr.nazwa as rodzaj, pci.nazwa as przebieg, rrg.nazwa as cechaGeometrii
from OT_SWRS_L as rs
left join OT_ZrodloDanych zd on rs.zrodloDanychGeometrycznych = zd.id
left join OT_KatIstnienia kt on rs.kategoriaIstnienia = kt.id
left join OT_PolozenieCieku pc on rs.polozenie = pc.id
left join OT_StatusEksploatacji se on rs.statusEksploatacji = se.id
left join OT_RodzajRzeki rr on rs.rodzaj = rr.id
left join OT_PrzebiegCieku pci on rs.przebieg = pci.id
left join OT_RodzajRepGeom rrg on rs.cechaGeometrii = rrg.id
with data;
create unique index mv_ot_swrs_l_idx 
on mv_ot_swrs_l using btree (lokalnyid);
create index mv_ot_swrs_l_sdx
on mv_ot_swrs_l using gist (geometria);


-- mv swkn
create materialized view mv_ot_swkn_l as
select kn.lokalnyId, kn.wersja, kn.geometria, kn.nazwa, kn.szerokosc, zd.nazwa as zrodloDanychGeometrycznych,
kt.nazwa as kategoriaIstnienia, pc.nazwa as polozenie, se.nazwa as statusEksploatacji, rrg.nazwa as cechaGeometrii
from OT_SWKN_L as kn 
left join OT_ZrodloDanych zd on kn.zrodloDanychGeometrycznych = zd.id
left join OT_KatIstnienia kt on kn.kategoriaIstnienia = kt.id
left join OT_PolozenieCieku pc on kn.polozenie = pc.id
left join OT_StatusEksploatacji se on kn.statusEksploatacji = se.id
left join OT_RodzajRepGeom rrg on kn.cechaGeometrii = rrg.id
with data;
create unique index mv_ot_swkn_l_idx 
on mv_ot_swkn_l using btree (lokalnyId);
create index mv_ot_swkn_l_sdx
on mv_ot_swkn_l using gist (geometria);

-- mv swrm
create materialized view mv_ot_swrm_l as
select rm.lokalnyId, rm.wersja, rm.geometria, rm.nazwa, rm.szerokosc, zd.nazwa as zrodloDanychGeometrycznych,
kt.nazwa as kategoriaIstnienia, pc.nazwa as polozenie
from OT_SWRM_L as rm
left join OT_ZrodloDanych zd on rm.zrodloDanychGeometrycznych = zd.id
left join OT_KatIstnienia kt on rm.kategoriaIstnienia = kt.id
left join OT_PolozenieCieku pc on rm.polozenie = pc.id
with data;
create unique index mv_ot_swrm_l_idx 
on mv_ot_swrm_l using btree (lokalnyId);
create index mv_ot_swrm_l_sdx
on mv_ot_swrm_l using gist (geometria);

-- mv siec wodna
create materialized view mv_ot_siecwodna as
select sw.lokalnyId, sw.wersja, sw.geometria, sw.nazwa, sw.szerokosc, zd.nazwa as zrodloDanychGeometrycznych,
kt.nazwa as kategoriaIstnienia, pc.nazwa as polozenie
from OT_SiecWodna as sw
left join OT_ZrodloDanych zd on sw.zrodloDanychGeometrycznych = zd.id
left join OT_KatIstnienia kt on sw.kategoriaIstnienia = kt.id
left join OT_PolozenieCieku pc on sw.polozenie = pc.id
with data;
create unique index mv_ot_siecwodna_idx
on mv_ot_siecwodna using btree (lokalnyId);
create index mv_ot_siecwodna_sdx
on mv_ot_siecwodna using gist (geometria);

-- mv obiekt topograficzny
create materialized view mv_ot_obiekttopograficzny as
select ot.lokalnyId, ot.wersja, zd.nazwa as zrodloDanychGeometrycznych, kt.nazwa as kategoriaIstnienia
from OT_ObiektTopograficzny as ot
left join OT_ZrodloDanych zd on ot.zrodloDanychGeometrycznych = zd.id
left join OT_KatIstnienia kt on ot.kategoriaIstnienia = kt.id
with data;
create unique index mv_ot_obiekttopograficzny_idx
on mv_ot_obiekttopograficzny using btree (lokalnyId);

-- alters for trigger
alter table OT_SWRS_L add column autor text;
alter table OT_SWRS_L add column dataDodania timestamp;

alter table OT_SWKN_L add column autor text;
alter table OT_SWKN_L add column dataDodania timestamp;

alter table OT_SWRM_L add column autor text;
alter table OT_SWRM_L add column dataDodania timestamp;

-- trigger
create function fun_insert_sw()
returns trigger as 
$body$
	begin 
		new.autor := current_user;
		new.dataDodania := current_timestamp;
		return new;
	end;
$body$
language plpgsql volatile
cost 100;

--trigger for swrs
create trigger trg_new_OT_SWRS_L
before insert
on OT_SWRS_L for each row execute procedure fun_insert_sw(); 

--trigger for swkn
create trigger trg_new_OT_SWKN_L
before insert
on OT_SWKN_L for each row execute procedure fun_insert_sw();

--trigger for swrm
create trigger trg_new_OT_SWRM_L
before insert
on OT_SWRM_L for each row execute procedure fun_insert_sw();


--function zad3
create or replace function f_raster_cieki(side_length decimal)
returns void as $body$
begin
  if side_length <=0 or side_length > 1000 then
    RAISE EXCEPTION 'Invalid side length. It must be between 1 and 1000 meters.';
  end if;

  drop table if exists raster_cieki;
  create table raster_cieki (
    id serial PRIMARY KEY,
    geom geometry,
    liczba_rs integer,
    srednia_rs text,
    liczba_kn integer,
    srednia_kn text,
    liczba_rm integer,
    srednia_rm text
  );
  
  declare
    xmin decimal;
    xmax decimal;
    ymin decimal;
    ymax decimal;
	
-- creating bounding box of range equal to all swrs swkn i swrm objects
  begin
    select
      MIN(ST_XMin(geometria)),
      MAX(ST_XMax(geometria)),
      MIN(ST_YMin(geometria)),
      MAX(ST_YMax(geometria))
    into xmin, xmax, ymin, ymax
    from (
      select geometria from ot_swrs_l
      union all
      select geometria from ot_swkn_l
      union all
      select geometria from ot_swrm_l
    ) as bbox;
    --creating square grid, 'moving' by side_length in x and y axes
    for x in xmin..xmax by side_length loop
      for y in ymin..ymax by side_length loop
	  --inserting the squares as geometries into raster_cieki table
        insert into raster_cieki (geom)
        values (ST_MakeEnvelope(x, y, x + side_length, y + side_length, 2180));
      end loop;
    end loop;
  end;

  declare
    rs_count integer;
    rs_avg decimal;
    kn_count integer;
    kn_avg decimal;
    rm_count integer;
    rm_avg decimal;
	r record;
  begin
  --for every square insert number of objects and average length if their centroids are inside the square
    for r in select * from raster_cieki loop
      select
        COUNT(*),
        AVG(ST_Length(geometria))
      into rs_count, rs_avg
      from OT_SWRS_L
      where ST_Within(ST_Centroid(geometria), r.geom);
      
      select
        COUNT(*),
        AVG(ST_Length(geometria))
      into kn_count, kn_avg
      from OT_SWKN_L
      where ST_Within(ST_Centroid(geometria), r.geom);
      select
        COUNT(*),
        AVG(ST_Length(geometria))
      into rm_count, rm_avg
      from OT_SWRM_L
      where ST_Within(ST_Centroid(geometria), r.geom);
	  --inserting data only to the specific row
      update raster_cieki
      set
        liczba_rs = rs_count,
        srednia_rs = rs_avg,
        liczba_kn = kn_count,
        srednia_kn = kn_avg,
        liczba_rm = rm_count,
        srednia_rm = rm_avg
      where id = r.id;
    end loop;
  end;
end;
$body$ language plpgsql volatile;






