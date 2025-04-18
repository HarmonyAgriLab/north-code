export class Account {
  name: string;
  nickname: string;
  sex: string;
  phone: string;
  number: string;

  constructor(name: string, nickname: string, sex: string, phone: string, number: string) {
    this.name = name;
    this.nickname = nickname;
    this.sex = sex;
    this.phone = phone;
    this.number = number;
  }
}