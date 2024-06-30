import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State bgColors: String[] =
    ["https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/1fb41113931998c9d72f614a0c3dcffd/Konachan.com%20-%20378456%20sample.jpg",
      "https://konachan.net/sample/d5cb9f11e3ed6af23a4286c5bd5233b4/Konachan.com%20-%20378252%20sample.jpg",
      "https://konachan.net/sample/53a8a892a4c36f3c9d96be289e02f65c/Konachan.com%20-%20378099%20sample.jpg",
      "https://konachan.net/sample/b62dd7f9bfecd2712d4818f800d01dc1/Konachan.com%20-%20378149%20sample.jpg",
      "https://konachan.net/sample/9bc194416b7a303b570acb4fc7cb38ef/Konachan.com%20-%20378151%20sample.jpg",
      "https://konachan.net/sample/6a2b1a51e129e3d1fd72937dd6e2e1e1/Konachan.com%20-%20378152%20sample.jpg",
      "https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/1fb41113931998c9d72f614a0c3dcffd/Konachan.com%20-%20378456%20sample.jpg",
      "https://konachan.net/sample/d5cb9f11e3ed6af23a4286c5bd5233b4/Konachan.com%20-%20378252%20sample.jpg",
      "https://konachan.net/sample/53a8a892a4c36f3c9d96be289e02f65c/Konachan.com%20-%20378099%20sample.jpg",
      "https://konachan.net/sample/b62dd7f9bfecd2712d4818f800d01dc1/Konachan.com%20-%20378149%20sample.jpg",
      "https://konachan.net/sample/9bc194416b7a303b570acb4fc7cb38ef/Konachan.com%20-%20378151%20sample.jpg",
      "https://konachan.net/sample/6a2b1a51e129e3d1fd72937dd6e2e1e1/Konachan.com%20-%20378152%20sample.jpg",
      "https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/1fb41113931998c9d72f614a0c3dcffd/Konachan.com%20-%20378456%20sample.jpg",
      "https://konachan.net/sample/d5cb9f11e3ed6af23a4286c5bd5233b4/Konachan.com%20-%20378252%20sample.jpg",
      "https://konachan.net/sample/53a8a892a4c36f3c9d96be289e02f65c/Konachan.com%20-%20378099%20sample.jpg",
      "https://konachan.net/sample/b62dd7f9bfecd2712d4818f800d01dc1/Konachan.com%20-%20378149%20sample.jpg",
      "https://konachan.net/sample/9bc194416b7a303b570acb4fc7cb38ef/Konachan.com%20-%20378151%20sample.jpg",
      "https://konachan.net/sample/6a2b1a51e129e3d1fd72937dd6e2e1e1/Konachan.com%20-%20378152%20sample.jpg"]
  scroller: Scroller = new Scroller()

  build() {

    Column({ space: 10 }) {
      Row() {
        Text("7_bit")
        Button({ type: ButtonType.Circle }).width(24).height(24)
      }.width("100%").justifyContent(FlexAlign.SpaceBetween)

      Grid(this.scroller) {
        ForEach(this.bgColors, (url: String) => {
          GridItem() {
            Image(url.toString()).height(200).borderRadius(10)
          }.onClick(() => {
            router.pushUrl({ url: 'pages/gitPage/git_page', params: { 'data': url } }, router.RouterMode.Single,
              error => {
                if (error) {
                  console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
                }
              });
          })
        })
      }
      .width("100%")
      .height("100%") // 滚动方向纵向
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(1) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .columnsTemplate('1fr 1fr 1fr') //设置行数 以及比例
      .borderRadius(10)
      .columnsGap(5) //间距
      .rowsGap(5) //间距

    }.padding(10).layoutWeight(1)

  }
}