show user;
-- 멤버 테이블
CREATE TABLE p1member(
    memberidx NUMBER(20) NOT NULL,
    memberid VARCHAR2(40) NOT NULL,
    nickname VARCHAR2(40) NOT NULL,
    memberpwd VARCHAR2(400) NOT NULL,
    membername VARCHAR2(400) NOT NULL,
    email VARCHAR2(400) NOT NULL,
    birthday VARCHAR2(8) NOT NULL,
    membertel VARCHAR2(11) NOT NULL,
    gender NUMBER(1) NOT NULL,
    registerday date DEFAULT sysdate,
    status NUMBER(1) DEFAULT 1,
    grade NUMBER(1) DEFAULT 1,
    point NUMBER(20) DEFAULT 1000,
    picture VARCHAR2(400) DEFAULT 'memberno.jpg',
    finallogin DATE DEFAULT sysdate,
    finalpwd DATE DEFAULT sysdate,
    CONSTRAINT p1member_pk_memberidx PRIMARY KEY(memberidx),
    CONSTRAINT p1member_uk_memberid UNIQUE(memberid),
    CONSTRAINT p1member_uk_nickname UNIQUE(nickname),
    CONSTRAINT p1member_uk_email UNIQUE(email),
    CONSTRAINT p1member_ck_gender CHECK(gender in (1,2)),
    CONSTRAINT p1member_ck_status CHECK(status in (0,1))
);
-- 멤버 테이블 시퀀스
CREATE SEQUENCE seq_p1member
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;
-- 숙박유형 테이블
CREATE TABLE p1hotelCategory(
    categoryCode number(2) not null,
    categoryName VARCHAR2(20) not null,
    CONSTRAINT p1hotelList_pk_hotelCategory PRIMARY KEY(hotelCategoryCode)
);
-- 숙소 테이블
CREATE TABLE p1hotelList(
    categoryCode NUMBER(2) NOT NULL,
    hotelidx NUMBER(4) NOT NULL,
    hotelName VARCHAR2(40) NOT NULL,
    businessTel VARCHAR2(11) NOT NULL,
    address VARCHAR2(100) NOT NULL,
    hotelInfo VARCHAR2(500),
    hotelOption VARCHAR2(300),
    hotelImg VARCHAR2(200) DEFAULT 'hotelno.jpg',
    hotelRegday DATE DEFAULT sysdate,
    hotelStatus NUMBER(1) DEFAULT 0,
    CONSTRAINT p1hotelList_pk_hotelidx PRIMARY KEY(hotelidx),
    CONSTRAINT p1hotelList_pk_hotelName UNIQUE(hotelName),
    CONSTRAINT p1hotelList_ck_hotelStatus CHECK(hotelStatus in (0,1,2,3,4)),  --0:비공개 1:공개 2:리모델링 4:삭제
    CONSTRAINT p1hotelList_pk_categorycode FOREIGN KEY(categoryCode) REFERENCES p1hotelCategory(categoryCode)
);

-- 숙소 테이블 시퀀스
CREATE SEQUENCE seq_p1hotelList
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;
-- 객실 테이블
CREATE TABLE p1roomList(
    roomidx NUMBER(4) NOT NULL,
    hotelidx NUMBER(4) NOT NULL,
    roomType VARCHAR2(3) NOT NULL,
    roomOption VARCHAR2(300),
    roomName VARCHAR2(40) NOT NULL,
    weekPrice NUMBER NOT NULL,
    weekendPrice NUMBER NOT NULL,
    roomInfo VARCHAR2(500),
    roomImg VARCHAR2(200) DEFAULT 'roomno.jpg',
    roomStatus NUMBER DEFAULT 0,
    roomPeriod1 DATE DEFAULT sysdate,
    roomPeriod2 DATE DEFAULT sysdate + 365,
    CONSTRAINT p1roomList_pk_roomidx PRIMARY KEY(roomidx),
    CONSTRAINT p1roomList_fk_hotelidx FOREIGN KEY(hotelidx) REFERENCES p1hotelList(hotelidx),
    CONSTRAINT p1roomList_ck_roomstatus CHECK(roomstatus in (0,1,2,3,4)) -- 등록직후 0 공개 1 잠시개시중단 2 삭제 4
);
-- 객실 테이블 시퀀스
CREATE SEQUENCE seq_p1roomList
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;
-- 찜목록 테이블
CREATE TABLE p1LikeList(
    likeStatus NUMBER DEFAULT 1,
    memberidx NUMBER(20),
    hotelidx NUMBER(4),
    CONSTRAINT p1LikeList_ck_likeStatus CHECK(likeStatus in (0,1)),
    CONSTRAINT p1LikeList_fk_memberidx FOREIGN KEY(memberidx) REFERENCES p1member(memberidx),
    CONSTRAINT p1LikeList_fk_hotelidx FOREIGN KEY(hotelidx) REFERENCES p1hotelList(hotelidx)
);
-- 숙소 조회수 테이블
CREATE TABLE p1hotelView(
    viewDate DATE DEFAULT sysdate,
    memberidx NUMBER(20),
    hotelidx NUMBER(4),
    CONSTRAINT p1hotelView_fk_memberidx FOREIGN KEY(memberidx) REFERENCES p1member(memberidx),
    CONSTRAINT p1hotelView_fk_hotelidx FOREIGN KEY(hotelidx) REFERENCES p1hotelList(hotelidx)
);
-- 예약 테이블
CREATE TABLE p1reserve(
    reserveidx NUMBER(20) NOT NULL,
    reserveDate DATE DEFAULT sysdate,
    memberidx NUMBER(20),
    hotelidx NUMBER(4),
    roomidx NUMBER(4),
    checkIn DATE NOT NULL,
    checkOut DATE NOT NULL,
    reserveStatus NUMBER DEFAULT 1,
    price NUMBER NOT NULL,
    vat NUMBER NOT NULL,
    CONSTRAINT p1reserve_pk_reserveidx PRIMARY KEY(reserveidx),
    CONSTRAINT p1reserve_ck_reserveStatus CHECK(reserveStatus in (0,1,2,3,4,5)), --0:취소 1:예약 2:체크인 3:체크아웃 4:리뷰 5:포인트
    CONSTRAINT p1reserve_ck_checkDate CHECK(checkOut > checkIn),
    CONSTRAINT p1reserve_fk_memberidx FOREIGN KEY(memberidx) REFERENCES p1member(memberidx),
    CONSTRAINT p1reserve_fk_hotelidx FOREIGN KEY(hotelidx) REFERENCES p1hotelList(hotelidx),
    CONSTRAINT p1reserve_fk_roomidx FOREIGN KEY(roomidx) REFERENCES p1roomList(roomidx)
);
-- 예약 테이블 시퀀스
CREATE SEQUENCE seq_p1reserve
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;


-- 리뷰 테이블
CREATE TABLE p1review(
    reviewidx NUMBER(20) NOT NULL,
    reserveidx NUMBER(20) NOT NULL,
    memberidx NUMBER(20),
    hotelidx NUMBER(4),
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(400) NOT NULL,
    star NUMBER(2,1) NOT NULL,
    reviewRegDate DATE DEFAULT sysdate,
    reviewStatus NUMBER DEFAULT 1,
    CONSTRAINT p1review_pk_reviewidx PRIMARY KEY(reviewidx),
    CONSTRAINT p1review_ck_reviewStatus CHECK(reviewStatus in (0,1)),
    CONSTRAINT p1review_fk_reserveidx FOREIGN KEY(reserveidx) REFERENCES p1reserve(reserveidx),
    CONSTRAINT p1review_fk_memberidx FOREIGN KEY(memberidx) REFERENCES p1member(memberidx),
    CONSTRAINT p1review_fk_hotelidx FOREIGN KEY(hotelidx) REFERENCES p1hotelList(hotelidx)
);
-- 리뷰 이미지 테이블
CREATE TABLE p1review_img(
    reviewidx NUMBER(20) NOT NULL,
    reviewImgidx NUMBER(20) NOT NULL,
    reviewImg VARCHAR2(200) NOT NULL,
    CONSTRAINT p1review_img_fk_reviewidx FOREIGN KEY(reviewidx) REFERENCES p1review(reviewidx)
);
-- 리뷰 테이블 시퀀스
CREATE SEQUENCE seq_p1review
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;
-- 리뷰 이미지 테이블 시퀀스
CREATE SEQUENCE seq_p1review_img
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;

INSERT INTO p1hotelCategory VALUES(10,'호텔');
INSERT INTO p1hotelCategory VALUES(20,'리조트');
INSERT INTO p1hotelCategory VALUES(30,'게스트하우스');
INSERT INTO p1hotelCategory VALUES(40,'모텔');
INSERT INTO p1hotelCategory VALUES(50,'펜션');
INSERT INTO p1hotelCategory VALUES(60,'호스텔');

commit;
SELECT * FROM USER_TAB_COLUMNS;