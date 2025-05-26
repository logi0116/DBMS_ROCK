use('test') //이걸 굳이 안 하더라도 기본 데이터 베이스, test 사용함. 생략시 기본 테스트 데이터베이스 사용

//테이블 생성,
//테이블 생성 후, 데이터 추가하는 기본 문법 : insertOne
//SQL 에서 사용하는 테이블, NOSQL 컬렉션으로 사용함
// 따라서 정확하게는 db.[컬렉션명].insertOne ({
// db.[테이블명].insertOne ({
//     [컬럼명] : [값],
//     name : '홍길동',
//     age : 20
//     favorite : ['축구', '농구']
//     ('test') 

// 한줄 실행 : ctrl + alt + s
// 전체 실행 : ctrl + alt + r

//하나 입력
// 예시
db.users.insertOne({
    name: '홍길동',
    age: 20,
    favorite: ['축구', '농구']
})

//하나 삭제
//db.[테이블명].deleteOne({[조건]})
db.users.deleteOne({ name: '홍길동' })


//하나 조회
//db.[테이블명].find({[조건]})
db.users.find();



//수정
//db.[테이블명].updateOne({[조건]}, {$set: {[컬럼명]: [값]}})
db.users.updateOne({ name: '홍길동' }, { $set: { age: 30 } })



//capped collection, 컬렉션 = 테이블
//컬렉션이 용량 초과하게 되면 가장 오래된 데이터 삭제
//기본문법
//db.createCollection('컬렉션명', {capped: true, size: [용량]})
//용량이 5kb인 컬렉션 생성, 부가 기능으로 용량 초과시 가장 오래된 데이터 삭제

db.createCollection('logs', { capped: true, size: 5000 })

//샘플 데이터 추가, 반복문을 이용해서, 샘플로 1000개 추가
for (let i = 0; i < 1000; i++) {
    db.logs.insertOne({
        message: '로그 메시지 ${i}',
        timestamp: new Date() //오라클로 표현하면 sysdate, 현재 날짜
    })
}

db.logs.find() //컬렉션에 있는 모든 데이터 조회, 컴파스 확인도 가능.



db.createCollection('logs6', { capped: true, size: 5000 })





for (let i = 1000; i < 2000; i++) {
    db.logs6.insertOne({
        message: `로그 메시지 ${i}`,
        timestamp: new Date() //오라클로 표현하면 sysdate, 현재 날짜
    })
}

for (let i = 0; i < 1000; i++) {
    db.logs6.insertOne({
        message: `로그 메시지 ${i}`,
        timestamp: new Date() //오라클로 표현하면 sysdate, 현재 날짜
    })
}


for (let i = 3000; i < 4000; i++) {
    db.logs6.insertOne({
        message: `로그 메시지 ${i}`,
        timestamp: new Date() //오라클로 표현하면 sysdate, 현재 날짜
    })
}

//로그 메시지 출력 5000개 현재 날짜로
for (let i = 0; i < 5000; i++) {
    db.logs6.insertOne({
        message: `로그 메시지 ${i}`,
        timestamp: new Date() //오라클로 표현하면 sysdate, 현재 날짜
    })
}


// 퀴즈 1. 한개 문서 삽입, 컬렉션 명 : users2
// 이름, 생년월일, 좋아하는 음식, 등록날짜

//컬렉션 생성 users2
db.createCollection('users2')

db.users2.insertOne({
    name: '이상록', // 이름
    birth: '1986-01-16', // 생년월일
    favoriteFood: ['김치찌개', '비빔밥', '만두'], // 좋아하는 음식
    createdAt: new Date()  // 등록날짜
})

//퀴즈 2. 
//컬렉션 명 : users2, 수정해보기


//항목들 중, 수정 2 문자열 추가해보기 


db.users2.updateOne({ name: '이상록' },
    { $set: { favoriteFood: ['김치찌개', '비빔밥', '만두', '수정 2'] } })

//항목들 중 음식 수정해보기
db.users2.updateOne({ name: '이상록' },
    { $set: { favoriteFood: ['김치찌개', '비빔밥', '짬뽕3 ', '짜장면'] } })


// 퀴즈 3
// users2 에서, 등록한 항목 삭제해보기.
db.users2.deleteOne({ birth: '1986-01-16' })

db.users2.find() 




format on sav