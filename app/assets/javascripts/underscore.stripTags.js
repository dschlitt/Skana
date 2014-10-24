function stripTags (str){
  if (str == null) return '';
  return String(str).replace(/<\/?[^>]+>/g, '');
}
