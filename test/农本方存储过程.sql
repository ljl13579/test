USE [Healthone]
GO
/****** Object:  StoredProcedure [dbo].[农本方]    Script Date: 2018-06-12 14:25:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[农本方]

@datetime datetime=''
as
begin
set @datetime=getdate()
delete from cfmx
insert into cfmx(cfid,ypid,ypmc,ypzl)
select distinct cast(Year(@datetime) as varchar(4))+cast(a.vaf01 as varchar(10)) + cast(vaf04 as varchar(1)) Cfid
,b.bby01 ypid
,b.bby05 ypmc
,a.vaf21 ypzl
from vaf1 a
join (select bby01,bby05 from bby1 where bby05 like '%' + @bby05 +'%') b on b.bby01=a.bby01
left join vaj1 e on e.vaf01=a.vaf01
where datediff(mm,vaf42,@datetime)<12 and
e.vak01 is not null and e.vak01 >0 and a.bby01>0
union all
select distinct cast(Year(@datetime) as varchar(4))+cast(a.vaf01 as varchar(10)) + cast(vaf04 as varchar(1)) Cfid
,b.bby01 ypid
,b.bby05 ypmc
,a.vaf21 ypzl
from vaf2 a
join (select bby01,bby05 from bby1 where bby05 like '%' + @bby05 +'%') b on b.bby01=a.bby01
left join vaj2 e on e.vaf01=a.vaf01
where datediff(mm,vaf42,@datetime)<12 and
e.vak01 is not null and e.vak01 >0 and a.bby01>0

insert into jkxx
select distinct cast(Year(@datetime) as varchar(4))+cast(a.vaf01 as varchar(10)) + cast(vaf04 as varchar(1)) Cfid
,vaf42 cfrq,vaf06 ghid,vaf06 blid,a.vaf01 yzid,'' bq,'' ch,0 zycf,vaa05 hzxm
,(case c.abw01 when '1' then '男' when '2' then '女' else '未知' end) xb
,cast(vaa10 as varchar(10)) + (case c.aau01 when 'Y' then '岁' when 'M' then '月' when 'D' then '天'
when 'H' then '小时' else '未知' end) nl
,a.bce03a ysxm,vaf27 cs,vaf28 ts,vaf28 fs,
@datetime czsj,'' dqsj,0 dqzt,0 clzt,'' bz,1 sf,vaf15 fyff
,'' yfbh,'' kzxx
from vaf1 a
left join vaa1 c on c.vaa01=a.vaa01
left join vaj1 e on e.vaf01=a.vaf01
join (select bby01,bby05 from bby1 where bby05 like '%' + @bby05 +'%') f on f.bby01=a.bby01
where datediff(mm,vaf42,@datetime)<12 and
e.vak01 is not null and e.vak01 >0 and a.bby01>0
and a.vaf01 not in(select yzid from jkxx)
union all
select distinct cast(Year(@datetime) as varchar(4))+cast(a.vaf01 as varchar(10)) + '-' + cast(vaf04 as varchar(1)) Cfid
,vaf42 cfrq,vaf06 ghid,vaf06 blid,a.vaf01 yzid,d.bck03 bq,b.bcq04b ch,1 zycf,vaa05 hzxm
,(case c.abw01 when '1' then '男' when '2' then '女' else '未知' end) xb
,cast(vaa10 as varchar(10)) + (case c.aau01 when 'Y' then '岁' when 'M' then '月' when 'D' then '天'
when 'H' then '小时' else '未知' end) nl
,a.bce03a ysxm,vaf27 cs,vaf28 ts,vaf28 fs,
@datetime czsj,'' dqsj,0 dqzt,0 clzt,'' bz,1 sf,vaf15 fyff
,'' yfbh,'' kzxx
from vaf2 a
left join vae1 b on b.vae01=a.vaf06
left join vaa1 c on c.vaa01=a.vaa01
left join bck1 d on d.bck01=a.bck01a
left join vaj2 e on e.vaf01=a.vaf01
join (select bby01,bby05 from bby1 where bby05 like '%' + @bby05 +'%') f on f.bby01=a.bby01
where datediff(mm,vaf42,@datetime)<12 and
e.vak01 is not null and e.vak01 >0 and a.bby01>0
and a.vaf01 not in(select yzid from jkxx)
end
