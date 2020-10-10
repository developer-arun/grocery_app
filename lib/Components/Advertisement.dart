class Advertisement{
  String url,name;
  int stars;
  Advertisement({String url})
  {
    this.url=url;
  }
  Advertisement.forSeller({String url,String name,int stars})
  {
      this.url=url;
      this.name=name;
      this.stars=stars;
  }
  Advertisement.forItem({String url,String name,String desc})
  {

  }
}