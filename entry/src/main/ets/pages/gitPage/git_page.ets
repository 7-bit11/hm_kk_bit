import router from '@ohos.router';

@Entry
@Component
struct GifPage {
  @State bgColors: String = "t.gif";
  @State top: number = 40
  @State bottom: number = 5
  @State left: number = 40
  @State right: number = 10

  build() {
    Column() {
      Image($r('app.media.ic_public_back'))
        .width(24)
        .height(24)
        .onClick(() => {
          router.back();
        }).margin(10)
      Image($rawfile(this.bgColors.toString())).objectFit(ImageFit.Contain).width("100%").height("100%")
    }.alignItems(HorizontalAlign.Start)
  }
}