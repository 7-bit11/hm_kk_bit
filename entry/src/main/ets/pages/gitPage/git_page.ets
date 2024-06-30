import router from '@ohos.router';

@Entry
@Component
struct GifPage {
  @State bgColors: String = "t.gif";
  @State top: number = 40
  @State bottom: number = 5
  @State left: number = 40
  @State right: number = 10
  private value: object = router.getParams();
  images: Array<String> = [this.value['data'].toString(), this.value['data'].toString(), this.value['data'].toString(),
    this.value['data'].toString(), this.value['data'].toString(), this.value['data'].toString()];

  build() {
    List({ space: 10 }) {
      ListItem() {
        Row() {
          Image($r('app.media.ic_public_back'))
            .width(24)
            .height(24)
            .onClick(() => {
              router.back();
            }).margin(10)
          Text("Flutter Appbar")
          Button({ type: ButtonType.Circle, stateEffect: true }) {
            LoadingProgress().width(20).height(20).color(0xFFFFFF)
          }.width(24).height(24).backgroundColor(0x317aff)
        }.justifyContent(FlexAlign.SpaceBetween).width("100%")
      }

      ListItem() {
        Image(this.value['data'].toString()).width("100%").objectFit(ImageFit.Auto).borderRadius(8)
      }

      ListItem() {
        Text("一些评论区常见问题的答案我写简介里吧").fontSize(18).fontWeight(FontWeight.Bold)
      }

      ListItem() {
        Text("1、要解释梅瑟莫的蛇本质无非三种途径：返祖、玛莉卡乱搞、非亲生。第一种解释过于万能，第二种解释需要构建的逻辑链也完全不比第三种少，我仅是基于第三种方向进行解读。2、米莉森在自己的对话里，格威的对话里，确实描述了其接近于玛莲妮亚的亲子关系。 3、涅翡丽·露确实有百智这个义父，但是百智全名：基甸·奥夫尼尔。涅翡丽·露没有继承百智的姓氏，关系并没那么密切。4、影之地断代的深入分析我其实认为与“丰饶时代的短暂”相关，但是逻辑链比较长，故本期暂不涉及5、“半神”的标注是灵活的，在葛瑞克大卢恩的描述中能读出葛孚雷也是半神的意思我的一些前置推理并未放在本视频中展开，可以看我做的【基础环学】与【进阶环学】同步一下。")
          .fontColor(Color.Grey)
      }

      ListItem() {
        Grid() {
          ForEach(this.images, (url: String) => {
            GridItem() {
              Image(url.toString()).height(100).width("100%").borderRadius(10).objectFit(ImageFit.Auto)
            }
          })
        }.columnsTemplate('1fr 1fr') //设置行数 以及比例
        .borderRadius(10)
        .columnsGap(5) //间距
        .rowsGap(5) //间距
      }
    }.padding(10)
  }
}