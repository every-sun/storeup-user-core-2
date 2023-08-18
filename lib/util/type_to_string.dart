
getInquiryType(str) {
  switch (str) {
    case '상품문의':
      return 'P';
    case '배송문의':
      return 'S';
    case '기타문의':
      return 'E';
    case '주문/결제':
      return 'O';
    case '반품/교환문의':
      return 'C';
    case '이벤트/쿠폰/적립금문의':
      return 'A';
  }
  return 'E';
}

getInquiryValue(type) {
  switch (type) {
    case 'P':
      return '상품문의';
    case 'S':
      return '배송문의';
    case 'E':
      return '기타문의';
    case 'O':
      return '주문/결제';
    case 'C':
      return '반품/교환문의';
    case 'A':
      return '이벤트/쿠폰/적립금문의';
  }
  return '상품문의';
}

getClaimReasonValue(type) {
  if (type == 'A') return '단순 변심';
  if (type =='B') return '상품 불량';
  if (type == 'C') return '서비스 불만족';
  if (type == 'D') return '포장 불량';
  if (type == 'F') return '배송오류';
  if (type == 'G') return '배송지연';
  if (type == 'H') return '상품 정보 변경';
  if (type == 'I') return '상품 품절';
  return '';
}