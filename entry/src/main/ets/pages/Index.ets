import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State bgColors: String[] =
    ["https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg",
      "https://konachan.net/sample/710cba2e286089bb623c2de3aa134952/Konachan.com%20-%20378419%20sample.jpg"]
  @State currentBp: string = 'unknown'

  build() {
    Column({ space: 10 }) {
      Row() {
        Text("7_bit")
        Button({ type: ButtonType.Circle }).width(24).height(24)
      }.width("100%").justifyContent(FlexAlign.SpaceBetween)

      GridRow({
        columns: 3,
        gutter: { x: 10, y: 10 },
        breakpoints: {
          value: ["400vp", "600vp", "1000vp"],
          reference: BreakpointsReference.WindowSize
        },
        direction: GridRowDirection.Row
      }) {
        ForEach(this.bgColors, (url: String) => {
          GridCol() {
            Image(url.toString()).height(200).borderRadius(10)
          }.onClick(()=>{
            router.pushUrl({url:'pages/gitPage/git_page'}, router.RouterMode.Single, error => {
              if (error) {
                console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
              }
            });
          })
        })
      }.width("100%").height("100%")
      .onBreakpointChange((breakpoint) => {
        this.currentBp = breakpoint
      })
    }.padding(10)

  }
}