password = 'pass123'
1.upto(5) do |i|
  User.create(
    email: "user-#{i}@example.com",
    name: "유저#{i}",
    sex: "F",
    password: password,
    password_confirmation: password,
    )
end
  School.create(
      schoolemail: '@dongduk.ac.kr', schoolname: '동덕여자대학교')
    School.create(
      schoolemail: '@hangyang.ac.kr', schoolname: '한양대학교')
    School.create(
      schoolemail: '@konkuk.ac.kr', schoolname: '건국대학교')
    School.create(
      schoolemail: '@korea.ac.kr', schoolname: '고려대학교')
    School.create(
      schoolemail: '@smu.ac.kr', schoolname: '상명대학교')
    School.create(
      schoolemail: '@yonsei.ac.kr', schoolname: '연세대학교')
    School.create(
      schoolemail: '@cau.ac.kr', schoolname: '중앙대학교')
    School.create(
      schoolemail: '@khu.ac.kr', schoolname: '경희대학교')
    School.create(
      schoolemail: '@ewha.ac.kr', schoolname: '이화여자대학교')
    School.create(
      schoolemail: '@sookmyung.ac.kr', schoolname: '숙명여자대학교')
    School.create(
      schoolemail: '@sogang.ac.kr', schoolname: '서강대학교')
    School.create(
      schoolemail: '@dongguk.ac.kr', schoolname: '동국대학교')
    School.create(
      schoolemail: '@hufs.ac.kr', schoolname: '한국외국어대학교')
    School.create(
      schoolemail: '@uos.ac.kr', schoolname: '서울시립대학교')
    School.create(
      schoolemail: '@hongik.ac.kr', schoolname: '홍익대학교')
    School.create(
      schoolemail: '@ssu.ac.kr', schoolname: '숭실대학교')
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
