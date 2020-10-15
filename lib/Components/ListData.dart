class ListData{
  String url,name;
  int stars;
  ListData({String url})
  {
    this.url=url;
  }
  ListData.forSeller({String url,String name,int stars})
  {
      this.url=url;
      this.name=name;
      this.stars=stars;
  }
  ListData.forItem({String url,String name,String desc})
  {
      this.url=url;
  }
}