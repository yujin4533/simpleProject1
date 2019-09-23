SELECT * FROM P1MEMBER;
SELECT * FROM P1HOTELCATEGORY;
SELECT * FROM P1HOTELLIST;
SELECT * FROM P1ROOMLIST;
SELECT * FROM P1LIKELIST;
SELECT * FROM P1RESERVE;
SELECT * FROM P1REVIEW;
SELECT * FROM P1REVIEW_IMG;
SELECT * FROM P1HOTELVIEW;

commit;
rollback;

SELECT *
FROM p1LikeList;

delete p1likelist ;

update p1reserve set reservestatus=4 where reserveidx=3;

update p1reserve set reserveStatus=2;

SELECT ROW_NUMBER() OVER(ORDER BY reserveidx DESC) NUM,memberId, reserveidx as roomidx,hotelRegDay,checkin_date,checkout_date,roomStatus,weekPrice,weekendPrice,roomName,A.hotelidx,hotelName
FROM
    (SELECT memberId,reserveidx,reserveDate as hotelRegDay,hotelidx,checkIn as checkin_date,checkOut as checkout_date,reserveStatus as roomStatus,price as weekPrice,vat as weekendPrice,roomidx
	 FROM p1reserve A JOIN p1member B
     ON A.memberIdx = B.memberIdx)A
left JOIN 
    (SELECT roomidx,roomName,A.hotelidx,hotelName
	 FROM p1roomlist A join p1hotellist B
	 ON A.hotelidx = B.hotelidx)B
ON A.roomidx = B.roomidx
order by roomidx;




SELECT roomidx,roomName,roomType,roomImg,roomOption,roomInfo,weekendPrice,weekPrice,roomPeriod1,roomPeriod2,roomStatus
		FROM p1roomList
		WHERE hotelidx=2;
select b.hotelStatus,a.hotelidx,a.hotelName 
		from 
			p1hotellist 
		A
		JOIN 
			(SELECT ROW_NUMBER() OVER(ORDER BY count(*) DESC) AS hotelStatus,hotelidx
			 FROM p1hotelview
			 WHERE viewdate=TO_DATE(SYSDATE,'yy/mm/dd')
			 GROUP BY hotelidx)
		B
		ON A.hotelidx=B.hotelidx
		WHERE b.hotelStatus BETWEEN 1 AND 10;

select title,content,reviewregdate,star,reviewimg,nickname,picture
from (
    select a.reviewidx,memberidx,hotelidx,title,content,reviewregdate,star,reviewimg
    from p1review A join (
                            select reviewidx, listagg(reviewImg,',') within group(order by reviewidx) as reviewImg
                            from p1review_img
                            group by reviewidx
                        )b
    on a.reviewidx=b.reviewidx
    where hotelidx=2 and reviewstatus=1
    )A
join
    (
    select memberidx,nickname,picture
    from p1member
    where status=1
    )B
on a.memberidx=b.memberidx
order by star;

select * from p1reserve where memberidx=2;

select * from(
SELECT ROW_NUMBER() OVER(ORDER BY reserveidx desc) NUM, reserveidx as roomidx,hotelRegDay,checkin_date,checkout_date,roomStatus,weekPrice,weekendPrice,roomType,roomName,A.hotelidx,hotelName,businessTel,address,hotelImg
		FROM
		    (SELECT roomidx,reserveidx,reserveDate as hotelRegDay,hotelidx,checkIn as checkin_date,checkOut as checkout_date,reserveStatus as roomStatus,price as weekPrice,vat as weekendPrice
		     FROM p1reserve
		     WHERE memberidx=2
		    )A
		JOIN 
		    (SELECT roomidx,roomType,roomName,A.hotelidx,hotelName,businessTel,address,hotelImg
		     FROM p1roomlist A join p1hotellist B
		     ON A.hotelidx = B.hotelidx
		    )B
		ON A.roomidx = B.roomidx)
        where num between 1 and 8;

select *
from p1reserve
where reserveidx=5;

select reserveidx,reserveDate,checkin_date,checkout_date,reserveStatus,weekPrice,weekendPrice,roomType,roomName,A.hotelidx,hotelName,businessTel,address,hotelImg
from
    (select roomidx,reserveidx,reserveDate,hotelidx,checkIn as checkin_date,checkOut as checkout_date,reserveStatus,price as weekPrice,vat as weekendPrice
    from p1reserve
    where memberidx=2
    )A
JOIN 
    (select roomidx,roomType,roomName,A.hotelidx,hotelName,businessTel,address,hotelImg
    from p1roomlist A join p1hotellist B
    on A.hotelidx = B.hotelidx
    )B
ON A.roomidx = B.roomidx; 
select *
--count(*)
from P1HOTELLIST A right join P1ROOMLIST B
on A.hotelidx=b.hotelidx
where a.hotelstatus=1 and b.roomperiod1 <= sysdate and sysdate <= b.roomperiod2 and b.roomstatus=1;

--select a.*,b.star,b.starcnt
select count(A.hotelidx)
from
    (select b.*,a.weekprice,a.weekendprice
    from 
        (select b.hotelidx, min(b.weekprice) as weekprice,min(b.weekendprice) as weekendprice
        from 
            (select roomidx from p1reserve where reservestatus=1 
--              and (sysdate BETWEEN CHECKIN+1 AND CHECKOUT-1
--              OR sysdate+1 BETWEEN CHECKIN+1 AND CHECKOUT-1
--              OR (sysdate < checkin+1 AND checkout-1<sysdate+1))
              ) A 
        right join 
              (select * from p1roomlist 
               where roomstatus=1
--               and ((0<=weekprice and weekprice<=999999) or (0<=weekendprice and weekendprice<=999999))
--               and to_number(substr(roomtype,2))>=1
--               and roomoption like '%%'
               ) B
        on a.roomidx=b.roomidx
        where a.roomidx is null
        group by b.hotelidx) A 
    join 
        (select hotelidx,hotelname,address,hotelimg from p1hotellist where hotelstatus=1
    --    and categorycode=10
--        and hoteloption like '%%'
--        and hotelinfo like '%%'
--        and hotelname like '%%'
--        and address like '%%'
        ) B
    on a.hotelidx=b.hotelidx)A
left join 
    (select hotelidx,avg(star) as star,count(star) as starCnt from p1review group by hotelidx ) B
on a.hotelidx=b.hotelidx
--where 0<=nvl(b.star,0) and nvl(b.star,0)<= 5 
;

select hotelidx,avg(star) as star,count(star) as starCnt from p1review group by hotelidx where 0<=avg(star) and avg(star)<= 5 ;

select min(min) from
(
select 1,min(weekprice) as min ,min(weekendprice) as min,max(weekprice),max(weekendprice) 
from p1roomlist 
where roomstatus=1
group by 1
);

with tt as
(
select min(weekprice) as min,max(weekprice) as max from p1roomlist where roomstatus=1
union all
select min(weekendprice) as min ,max(weekendprice) as max from p1roomlist where roomstatus=1
)
select min(min),max(max) from tt;

select distinct col as lontion
		from(
			Select Regexp_Substr((select hoteloption from (select listagg(hoteloption||',')within group (order by hoteloption) as hoteloption
			from (select 1,hoteloption from p1hotellist)
			group by 1)),'[^,]+', 1, Level) COL From Dual
			Connect By Regexp_Substr((select hoteloption from (select listagg(hoteloption||',')within group (order by hoteloption) as hoteloption
			from (select 1,hoteloption from p1hotellist)
			group by 1)), '[^,]+', 1, Level) Is Not Null
		);

select * from P1HOTELCATEGORY;
update p1roomlist set roomstatus=1;
update p1hotellist set hotelstatus=1;
SELECT * FROM p1hotelcategory;


SELECT hotelName
FROM p1hotellist
WHERE lower(hotelName) like '%'||lower(#{searchWord})||'%';

select a.*,b.starCnt,b.starRatng from
(
    select a.hotelidx,a.address,a.hotelImg,A.hotelName
    from 
        p1hotellist A 
    join 
        (select hotelidx
         from
            (
            select ROW_NUMBER() OVER(ORDER BY max(roomperiod1))as num,hotelidx,max(roomperiod1)
            from p1roomlist
            where roomstatus=1
            group by hotelidx
            )
        where num between 1 and 9)B
    on a.hotelidx=b.hotelidx
)A left join(  
    select hotelidx,count(*) as starCnt,avg(star) as starRatng
    from p1review
    group by hotelidx
) B
on a.hotelidx=b.hotelidx
;

select a.*,b.starCnt,b.starRatng from
(
    select a.hotelidx,a.address,a.hotelImg,A.hotelName
    from 
        p1hotellist A 
    join 
        (select hotelidx
         from
            (
            select ROW_NUMBER() OVER(ORDER BY count(*))as num,hotelidx 
            from p1reserve 
            where reservestatus=1 
            group by hotelidx
            )
        where num between 1 and 9)B
    on a.hotelidx=b.hotelidx
)A left join(  
    select hotelidx,count(*) as starCnt,avg(star) as starRatng
    from p1review
    group by hotelidx
) B
on a.hotelidx=b.hotelidx
;

select ROW_NUMBER() OVER(ORDER BY count(*))as num,hotelidx 
from p1reserve 
where reservestatus=1 
group by hotelidx;

select b.categoryname,a.* from
(select hotelidx,hotelname,businesstel,address,hotelinfo,hoteloption,hotelimg  
 from p1hotellist 
 where hotelstatus=1 and hotelidx=4) A join P1HOTELCATEGORY B
on a.categorycode=b.categorycode;

select a.* 
from 
    (select roomidx,hotelidx,roomType,roomOption,roomName,weekPrice,weekendPrice,roomInfo,roomImg
    from p1roomlist 
    where roomstatus=1 and hotelidx=3 and sysdate between roomperiod1 and roomperiod2
      and to_number(substr(roomType,2))>0
    ) A 
left join
    (
    select roomidx
    from p1reserve
    where reservestatus>0
      and (sysdate BETWEEN CHECKIN+1 AND CHECKOUT-1
      and sysdate BETWEEN CHECKIN+1 AND CHECKOUT-1
      and (sysdate<CHECKIN+1 and sysdate<CHECKOUT-1))
    )b
on a.roomidx=b.roomidx
where b.roomidx is null
    ;

select to_char(sysdate+1, 'd'),to_char(sysdate+2, 'd'),to_char(sysdate+3, 'd'),to_char(sysdate, 'd'),to_char(sysdate, 'd') from dual;

select weekprice*to_char(sysdate+1, 'd')
from p1roomlist;

select to_char(to_date('2019-09-05','yyyy-mm-dd'), 'd'),to_char(to_date('2019-09-06','yyyy-mm-dd'), 'd'),to_char(to_date('2019-09-07','yyyy-mm-dd'), 'd') ,to_char(to_date('2019-09-08','yyyy-mm-dd'), 'd') 
from dual;

select to_date('2019-09-06','yyyy-mm-dd')-to_date('2019-09-05','yyyy-mm-dd')
from dual;

select hotelName,address,hotelImg ,a.hotelidx,roomType,roomName,weekPrice,WeekendPrice
from 
    (select hotelidx,roomType,roomName,weekPrice,WeekendPrice
    from p1roomlist
    where roomstatus=1 and sysdate between roomperiod1 and roomperiod2 and roomidx=5) B
JOIN
    (select hotelidx,hotelName,address,hotelImg from p1hotellist where hotelStatus=1) A
ON a.hotelidx=b.hotelidx;

select * from p1reserve;


select *
from p1reserve
where reserveStatus>0 
and (sysdate BETWEEN CHECKIN+1 AND CHECKOUT-1
      and sysdate BETWEEN CHECKIN+1 AND CHECKOUT-1
      and (sysdate<CHECKIN+1 and sysdate<CHECKOUT-1))
and hotelidx=3;

       
select hotelidx,roomtype
from p1roomlist
where roomidx=3;

SELECT COUNT(*)
		FROM p1reserve
		WHERE reserveStatus>0 
        		AND (sysdate BETWEEN CHECKIN+1 AND CHECKOUT-1
		     OR sysdate BETWEEN CHECKIN+1 AND CHECKOUT-1
		     OR (sysdate<CHECKIN+1 and sysdate<CHECKOUT-1))
		and roomidx=4
--		AND (#{checkin_date} BETWEEN CHECKIN+1 AND CHECKOUT-1
--		     OR #{checkout_date} BETWEEN CHECKIN+1 AND CHECKOUT-1
--		     OR (#{checkin_date}<![CDATA[<]]>CHECKIN+1 and #{checkout_date}<![CDATA[<]]>CHECKOUT-1))
--		and roomidx=#{roomidx}
        ;
        
SELECT COUNT(*)
FROM p1reserve
WHERE reserveStatus>0 
AND ('19/09/06' BETWEEN CHECKIN+1 AND CHECKOUT-1
     OR'19/09/07' BETWEEN CHECKIN+1 AND CHECKOUT-1
     OR ('19/09/06'<CHECKIN+1 and CHECKOUT-1<'19/09/07'))
AND roomidx=2;

select *
from p1reserve
where roomidx;

SELECT A.* 
FROM 
    (SELECT roomidx,hotelidx,roomType,roomOption,roomName,weekPrice,weekendPrice,roomInfo,roomImg
     FROM p1roomlist 
     WHERE roomstatus=1 AND hotelidx=3 AND SYSDATE BETWEEN roomperiod1 AND roomperiod2
--     <if test="per>=0 and per!=null">
--       AND to_number(SUBSTR(roomType,2))<![CDATA[>=]]>#{per}
--     </if>
) A 
LEFT JOIN
    (SELECT roomidx
     FROM p1reserve
     WHERE reservestatus>0
--     <if test='checkin_date!="" and checkout_date!="" and checkin_date!=null and checkout_date!=null'>
--       AND (   #{checkin_date} BETWEEN CHECKIN+1 AND CHECKOUT-1
--           OR #{checkout_date} BETWEEN CHECKIN+1 AND CHECKOUT-1
--           OR (#{checkin_date}<![CDATA[<]]>CHECKIN+1 and CHECKOUT-1<![CDATA[<]]>#{checkout_date}))
--     </if>
)B
ON A.roomidx=B.roomidx
WHERE B.roomidx IS NULL;

select A.*,nvl2(likestatus,1,0) heart
from 
(SELECT A.*,B.starRating,B.starCnt
		FROM
		    (SELECT ROW_NUMBER() OVER(ORDER BY B.hotelidx) NUM,B.*,A.weekPrice,A.weekendPrice
		     FROM 
		        (SELECT B.hotelidx, min(b.weekPrice) as weekPrice,min(b.weekendPrice) as weekendPrice
		         FROM 
		            (SELECT roomidx 
		             FROM p1reserve 
--		             <if test='checkin_date=="" or checkout_date=="" or checkin_date==null or checkout_date==null'>
--		             	WHERE reserveStatus<![CDATA[>]]>70
--		             </if> 
--		             <if test='checkin_date!="" and checkout_date!="" and checkin_date!=null and checkout_date!=null'>
--			             WHERE reserveStatus<![CDATA[>]]>0
--  			               and (#{checkin_date} BETWEEN CHECKIN+1 AND CHECKOUT-1
--				               OR #{checkout_date} BETWEEN CHECKIN+1 AND CHECKOUT-1
--				               OR (#{checkin_date}<![CDATA[<]]>CHECKIN+1 AND CHECKOUT-1<![CDATA[<]]>#{checkout_date}))
--		             </if> 
		              ) A 
		        RIGHT JOIN 
		              (SELECT * 
		               FROM p1roomlist 
		               WHERE roomstatus=1
--		               <if test="minPrice>=0 and minPrice!=null and maxPrice>=0 and maxPrice!=null">	
--		               AND ((#{minPrice}<![CDATA[<=]]>weekPrice AND weekPrice<![CDATA[<=]]>#{maxPrice}) OR (#{minPrice}<![CDATA[<=]]>weekendPrice and weekendPrice<![CDATA[<=]]>#{maxPrice}))
--		               </if> 
--		               <if test="per>=0 and per!=null">	
--		               AND to_number(substr(roomType,2))<![CDATA[>=]]>#{per}
--		               </if>
--		               <if test="roomOptionList!=null">and 
--				      	<foreach collection="roomOptionList" item="item" index="index" separator="and" open="(" close=")">
--				      		roomOption LIKE '%'||#{item}||'%'
--				      	</foreach> 
--			      	  </if> 
		               ) B
		        ON A.roomidx=B.roomidx
		        WHERE A.roomidx IS NULL
		        GROUP BY B.hotelidx
		        ) A 
		    JOIN 
		        (SELECT hotelidx,hotelName,address,hotelImg 
		         FROM p1hotellist 
		         WHERE hotelStatus=1
--		         <if test="categoryCodeList!=null">and
--					<foreach collection="categoryCodeList" item="item" index="index" separator="or" open="(" close=")">
--				    	categoryCode LIKE '%'||#{item}||'%'
--				    </foreach> 
--			     </if>
--			     <if test="hotelOptionList!=null">and
--				      <foreach collection="hotelOptionList" item="item" index="index" separator="and" open="(" close=")">
--				      	hotelOption LIKE '%'||#{item}||'%'
--				      </foreach> 
--			     </if>
--			     <if test='searchWord!="" and searchWord!=null'>
--				 	and (
--				 	hotelInfo like '%'||#{searchWord}||'%' 
--				 	OR hotelName like '%'||#{searchWord}||'%' 
--		        	OR address like '%'||#{searchWord}||'%' 
--				 	)
--			     </if>
--			      <if test='hotelName!="" and hotelName!=null'>
--				  	AND hotelName like '%'||#{hotelName}||'%'
--			      </if>
		        ) B
		    ON A.hotelidx=B.hotelidx
--		    <if test='sort!=null and !"".equals(sort)'>
--		    	order by ${sort}
--		    </if>
		    )A
		LEFT JOIN 
		    (SELECT hotelidx,avg(star) as starRating,count(star) as starCnt 
		     FROM p1review 
		     GROUP BY hotelidx ) B
		ON A.hotelidx=B.hotelidx
--    	WHERE NUM BETWEEN #{startRno} AND #{endRno}
--		<if test="minStar>=0 and minStar!=null and maxStar>=0 and maxStar!=null">
--	    	AND NVL(B.starRating,0) BETWEEN #{minStar} AND #{maxStar}
--	    </if>
)A left join (select likestatus,hotelidx from p1likelist where memberidx=2 and likestatus=1) B
on A.hotelidx=B.hotelidx;


select * from
	(
	select ROW_NUMBER() OVER(ORDER BY b.hotelidx) NUM,a.star,a.starcnt,address, name, img, largeCategoryontionCode, fk_hotelid as fk_LargeCategoryCode
	from (select * from lontion a left join (select hotelidx,avg(star) as star,count(*) as starcnt
			  from review
			  group by hotelidx) b
    		on a.hotelidx=b.hotelidx
    		) a join (
						 select likelistid,fk_hotelid from likelist where status=1 and fk_memberid=#{memberid}
						 ) b
	on a.largeCategoryontionCode=b.fk_hotelid
	)  ;
	where num between #{startRno} and #{endRno};
    
    
    select ROW_NUMBER() OVER(ORDER BY b.hotelidx) NUM ,A.*,b.likestatus
    from
(    select A.*,b.star,b.starcnt from (select hotelidx,address,hotelname,hotelinfo,hotelimg from p1hotellist where hotelstatus=1)a left join (select hotelidx,avg(star) star, count(*) as starcnt
                                            from p1review
                                            group by hotelidx)b
            on a.hotelidx=b.hotelidx)a join (select hotelidx,likestatus from p1likelist where memberidx=2 and likestatus=1) b
            on a.hotelidx=b.hotelidx;