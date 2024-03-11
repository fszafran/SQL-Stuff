
--extends
CREATE EXTENSION postgis;

--lookups
create table ot_zrodlo_danych (
    id serial primary key,
    nazwa text not null
);
create table ot_kat_istnienia (
    id serial primary key,
    nazwa text not null
);
create table ot_rodzaj_rzeki (
    id serial primary key,
    nazwa text not null
);
create table ot_status_eksploatacji (
    id serial primary key,
    nazwa text not null
);
create table ot_przebieg_cieku (
    id serial primary key,
    nazwa text not null
);
create table ot_rodzaj_repo (
	id serial primary key,
	nazwa text not null
);
create table ot_polozenie_cieku (
	id serial primary key,
	nazwa text not null
);

insert into ot_zrodlo_danych(nazwa) values 
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
insert into ot_kat_istnienia(nazwa) values 
('eksploatowany'),
('w budowie'),
('zniszczony'),
('nieczynny');
insert into ot_rodzaj_rzeki(nazwa) values 
('rzeka'),
('strumień, potok lub struga');
insert into ot_status_eksploatacji(nazwa) values 
('nieżeglowny'),
('żeglowny');
insert into ot_przebieg_cieku(nazwa) values 
('ciek główny'),
('ramię boczne');
insert into ot_rodzaj_repo(nazwa) values 
('sztuczny łącznik');
insert into ot_polozenie_cieku(nazwa) values 
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
-- 	zrodloDanychGeometrycznych integer references ot_zrodlo_danych(id) not null,
-- 	kategoriaIstnienia integer references ot_kat_istnienia(id),
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
-- 	zrodloDanychGeometrycznych integer references ot_zrodlo_danych(id) not null,
-- 	kategoriaIstnienia integer references ot_kat_istnienia(id),
-- 	uwagi text,
-- 	informacjaDodatkowa text,
-- 	kodKarto10k text,
-- 	kodKarto250k text,
-- 	skrotKartograficzny text,
-- 	identyfikatorPRNG text,
-- 	polozenie integer references ot_polozenie_cieku(id),
-- 	szerokosc decimal check (szerokosc >=0),
-- 	nazwa text,
-- 	geometria GEOMETRY(LINESTRING,2180) not null	
-- );

create table ot_swrs_l(
	lokalnyId text not null primary key,
	przestrzenNazw text not null,
	wersja timestamp not null,
	poczatekWersjiObiektu timestamp not null,
	koniecWersjiObiektu timestamp,
	oznaczenieZmiany text not null,
	zrodloDanychGeometrycznych integer references ot_zrodlo_danych(id) not null,
	kategoriaIstnienia integer references ot_kat_istnienia(id),
	uwagi text,
	informacjaDodatkowa text,
	kodKarto10k text,
	kodKarto250k text,
	skrotKartograficzny text,
	identyfikatorPRNG text,
	polozenie integer references ot_polozenie_cieku(id),
	szerokosc decimal check (szerokosc >=0),
	nazwa text,
	geometria GEOMETRY(LINESTRING,2180) not null,
	rodzaj integer references ot_rodzaj_rzeki(id) not null,
	statusEksploatacji integer references ot_status_eksploatacji(id) not null,
	przebieg integer references ot_przebieg_cieku(id),
	cechaGeometrii integer references ot_rodzaj_repo(id),
	identyfikatorMPHP text
);

create table ot_swkn_l(
	lokalnyId text not null primary key,
	przestrzenNazw text not null,
	wersja timestamp not null,
	poczatekWersjiObiektu timestamp not null,
	koniecWersjiObiektu timestamp,
	oznaczenieZmiany text not null,
	zrodloDanychGeometrycznych integer references ot_zrodlo_danych(id) not null,
	kategoriaIstnienia integer references ot_kat_istnienia(id),
	uwagi text,
	informacjaDodatkowa text,
	kodKarto10k text,
	kodKarto250k text,
	skrotKartograficzny text,
	identyfikatorPRNG text,
	polozenie integer references ot_polozenie_cieku(id),
	szerokosc decimal check (szerokosc >=0),
	nazwa text,
	geometria GEOMETRY(LINESTRING,2180) not null,
	statusEksploatacji integer references ot_status_eksploatacji(id) not null,
	cechaGeometrii integer references ot_rodzaj_repo(id),
	identyfikatorMPHP text
);
create table ot_referencja_do_obiektu(
	lokalnyId text primary key not null,
	przestrzenNazw text not null
);

create table ot_swrm_l(
	lokalnyId text not null primary key,
	przestrzenNazw text not null,
	wersja timestamp not null,
	poczatekWersjiObiektu timestamp not null,
	koniecWersjiObiektu timestamp,
	oznaczenieZmiany text not null,
	zrodloDanychGeometrycznych integer references ot_zrodlo_danych(id) not null,
	kategoriaIstnienia integer references ot_kat_istnienia(id),
	uwagi text,
	informacjaDodatkowa text,
	kodKarto10k text,
	kodKarto250k text,
	skrotKartograficzny text,
	identyfikatorPRNG text,
	polozenie integer references ot_polozenie_cieku(id),
	szerokosc decimal check (szerokosc >=0),
	nazwa text,
	geometria GEOMETRY(LINESTRING,2180) not null,
	OT_ReferencjaDoObiektu_id text references ot_referencja_do_obiektu(lokalnyId)
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
--create index idx_ot_swrs_l_localnyid on ot_swrs_l using btree(localnyId);
create index idx_ot_swrs_l_zrodlo on ot_swrs_l(zrodloDanychGeometrycznych);
create index idx_ot_swrs_l_kategoria on ot_swrs_l(kategoriaIstnienia);
create index idx_ot_swrs_l_polozenie on ot_swrs_l(polozenie);
create index idx_ot_swrs_l_status on ot_swrs_l(statusEksploatacji);
create index idx_ot_swrs_l_przebieg on ot_swrs_l(przebieg);
create index idx_ot_swrs_l_cecha on ot_swrs_l(cechaGeometrii);
create index idx_ot_swrs_l_geom on ot_swrs_l using gist(geometria);

--swkn_l indexes
--create index idx_ot_swkn_l_localnyid on ot_swkn_l using btree(localnyId);
create index idx_ot_swkn_l_zrodlo on ot_swkn_l(zrodloDanychGeometrycznych);
create index idx_ot_swkn_l_kategoria on ot_swkn_l(kategoriaIstnienia);
create index idx_ot_swkn_l_polozenie on ot_swkn_l(polozenie);
create index idx_ot_swkn_l_status on ot_swkn_l(statusEksploatacji);
create index idx_ot_swkn_l_cecha on ot_swkn_l(cechaGeometrii);
create index idx_ot_swkn_l_geom on ot_swkn_l using gist(geometria);

--swrm_l indexes
--create index idx_ot_swrm_l_localnyid on ot_swrm_l using btree(localnyId);
create index idx_ot_swrm_l_fk on ot_swrm_l(OT_ReferencjaDoObiektu_id);
create index idx_ot_swrm_l_zrodlo on ot_swrm_l(zrodloDanychGeometrycznych);
create index idx_ot_swrm_l_kategoria on ot_swrm_l(kategoriaIstnienia);
create index idx_ot_swrm_l_polozenie on ot_swrm_l(polozenie);
create index idx_ot_swrm_l_geom on ot_swrm_l using gist(geometria);

-- mv swrs
create materialized view mv_ot_swrs_l as
select rs.lokalnyId, rs.wersja, rs.geometria, rs.nazwa, rs.szerokosc, zd.nazwa as zrodloDanychGeometrycznych,
kt.nazwa as kategoriaIstnienia, pc.nazwa as polozenie, se.nazwa as statusEksploatacji, rr.nazwa as rodzaj, pci.nazwa as przebieg, rrg.nazwa as cechaGeometrii
from ot_swrs_l as rs
left join ot_zrodlo_danych zd on rs.zrodloDanychGeometrycznych = zd.id
left join ot_kat_istnienia kt on rs.kategoriaIstnienia = kt.id
left join ot_polozenie_cieku pc on rs.polozenie = pc.id
left join ot_status_eksploatacji se on rs.statusEksploatacji = se.id
left join ot_rodzaj_rzeki rr on rs.rodzaj = rr.id
left join ot_przebieg_cieku pci on rs.przebieg = pci.id
left join ot_rodzaj_repo rrg on rs.cechaGeometrii = rrg.id
with data;
create unique index mv_ot_swrs_l_idx 
on mv_ot_swrs_l using btree (lokalnyid);
create index mv_ot_swrs_l_sdx
on mv_ot_swrs_l using gist (geometria);


-- mv swkn
create materialized view mv_ot_swkn_l as
select kn.lokalnyId, kn.wersja, kn.geometria, kn.nazwa, kn.szerokosc, zd.nazwa as zrodloDanychGeometrycznych,
kt.nazwa as kategoriaIstnienia, pc.nazwa as polozenie, se.nazwa as statusEksploatacji, rrg.nazwa as cechaGeometrii
from ot_swkn_l as kn 
left join ot_zrodlo_danych zd on kn.zrodloDanychGeometrycznych = zd.id
left join ot_kat_istnienia kt on kn.kategoriaIstnienia = kt.id
left join ot_polozenie_cieku pc on kn.polozenie = pc.id
left join ot_status_eksploatacji se on kn.statusEksploatacji = se.id
left join ot_rodzaj_repo rrg on kn.cechaGeometrii = rrg.id
with data;
create unique index mv_ot_swkn_l_idx 
on mv_ot_swkn_l using btree (lokalnyId);
create index mv_ot_swkn_l_sdx
on mv_ot_swkn_l using gist (geometria);

-- mv swrm
create materialized view mv_ot_swrm_l as
select rm.lokalnyId, rm.wersja, rm.geometria, rm.nazwa, rm.szerokosc, zd.nazwa as zrodloDanychGeometrycznych,
kt.nazwa as kategoriaIstnienia, pc.nazwa as polozenie
from ot_swrm_l as rm
left join ot_zrodlo_danych zd on rm.zrodloDanychGeometrycznych = zd.id
left join ot_kat_istnienia kt on rm.kategoriaIstnienia = kt.id
left join ot_polozenie_cieku pc on rm.polozenie = pc.id
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
left join ot_zrodlo_danych zd on sw.zrodloDanychGeometrycznych = zd.id
left join ot_kat_istnienia kt on sw.kategoriaIstnienia = kt.id
left join ot_polozenie_cieku pc on sw.polozenie = pc.id
with data;
create unique index mv_ot_siecwodna_idx
on mv_ot_siecwodna using btree (lokalnyId);
create index mv_ot_siecwodna_sdx
on mv_ot_siecwodna using gist (geometria);

-- mv obiekt topograficzny
create materialized view mv_ot_obiekttopograficzny as
select ot.lokalnyId, ot.wersja, zd.nazwa as zrodloDanychGeometrycznych, kt.nazwa as kategoriaIstnienia
from OT_ObiektTopograficzny as ot
left join ot_zrodlo_danych zd on ot.zrodloDanychGeometrycznych = zd.id
left join ot_kat_istnienia kt on ot.kategoriaIstnienia = kt.id
with data;
create unique index mv_ot_obiekttopograficzny_idx
on mv_ot_obiekttopograficzny using btree (lokalnyId);

-- alters for trigger
alter table ot_swrs_l add column autor text;
alter table ot_swrs_l add column dataDodania timestamp;

alter table ot_swkn_l add column autor text;
alter table ot_swkn_l add column dataDodania timestamp;

alter table ot_swrm_l add column autor text;
alter table ot_swrm_l add column dataDodania timestamp;

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
on ot_swrs_l for each row execute procedure fun_insert_sw(); 

--trigger for swkn
create trigger trg_new_OT_SWKN_L
before insert
on ot_swkn_l for each row execute procedure fun_insert_sw();

--trigger for swrm
create trigger trg_new_OT_SWRM_L
before insert
on ot_swrm_l for each row execute procedure fun_insert_sw();


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
      from ot_swrs_l
      where ST_Within(ST_Centroid(geometria), r.geom);
      
      select
        COUNT(*),
        AVG(ST_Length(geometria))
      into kn_count, kn_avg
      from ot_swkn_l
      where ST_Within(ST_Centroid(geometria), r.geom);
      select
        COUNT(*),
        AVG(ST_Length(geometria))
      into rm_count, rm_avg
      from ot_swrm_l
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






