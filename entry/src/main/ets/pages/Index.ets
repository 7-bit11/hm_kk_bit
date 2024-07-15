import router from '@ohos.router';
import HotListEntity, { Topic } from '../entitys/hot_list_entity';
import hotList from "../model/hot_list_model"
import { borderRadiuses } from '@ohos.arkui.node';
import { PageOneBuilder } from './PageOne';

@Entry
@Component
struct Index {
  pageStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.pageStack) {
    }.onAppear(() => {
      this.pageStack.pushPathByName("PageOne", null, false);
    })
    .hideNavBar(true)
  }

  // scroller: Scroller = new Scroller()
  // @State hotListData: HotListEntity = new HotListEntity();
  // pageStack: NavPathStack = new NavPathStack()
  //
  // aboutToAppear() {
  //   console.error("aboutToAppear============");
  //   hotList.getHotListEntity().then(data => {
  //     this.hotListData = data;
  //   });
  //
  // }
  //
  // build() {
  //   Navigation(this.pageStack) {
  //     // Grid(this.scroller) {
  //     //   ForEach(this.hotListData.data?.topics, (topic: Topic) => {
  //     //     GridItem() {
  //     //       Column() {
  //     //         Image(topic.vertical_image_url)
  //     //           .height(250)//.borderRadius(borderRadiuses(10))
  //     //           .alt($rawfile('loading.gif'))
  //     //           .width("100%")
  //     //           .objectFit(ImageFit.Fill)
  //     //           .border({
  //     //             radius: {
  //     //               topLeft: 6,
  //     //               topRight: 6
  //     //             }
  //     //           })
  //     //         Text(topic.title).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).padding(5)
  //     //         Text(topic.tags?.join("|")).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).padding(5)
  //     //       }
  //     //       .borderRadius(6)
  //     //       .backgroundColor($r("app.color.245"))
  //     //     }.onClick(() => {
  //     //       // router.pushUrl({
  //     //       //   url: 'pages/gitPage/git_page', params: {
  //     //       //     'data': topic.cover_image_url,
  //     //       //     'name': topic.title,
  //     //       //     'id':topic.id
  //     //       //   }
  //     //       // },
  //     //       //   router.RouterMode.Single,
  //     //       //   error => {
  //     //       //     if (error) {
  //     //       //       console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
  //     //       //     }
  //     //       //   });
  //     //
  //     //     })
  //     //   })
  //     // }
  //     // .width("100%")
  //     // .height("100%") // 滚动方向纵向
  //     // .scrollBar(BarState.On) // 滚动条常驻显示
  //     // .scrollBarColor(Color.Gray) // 滚动条颜色
  //     // .scrollBarWidth(1) // 滚动条宽度
  //     // .edgeEffect(EdgeEffect.None)
  //     // .columnsTemplate('1fr 1fr') //设置行数 以及比例
  //     // .borderRadius(10)
  //     // .columnsGap(5) //间距
  //     // .rowsGap(5) //间距
  //     // .padding(10)
  //     // .onAppear(() => {
  //     //   this.pageStack.pushPathByName("PageOne", null, false);
  //     // })
  //
  //     // }.padding(10).layoutWeight(1)
  //
  //   }.title('LoadingMoreListDemo').titleMode(NavigationTitleMode.Free)
  //   // .onAppear(() => {
  //   //   this.pageStack.pushPathByName("PageOne", null, false);
  //   // })
  //   .navDestination(this.PagesMap)
  //
  //   //.menus(this.NavigationMenus())
  // }
  //
  // @Builder
  // PagesMap(name: string) {
  //   if (name == 'PageOne') {
  //     PageOneBuilder()
  //   }
  // }
  //
  // @Builder
  // NavigationMenus() {
  //   Image('resources/base/media/startIcon.png')
  //     .width(24)
  //     .height(24).onClick(() => {
  //     router.pushUrl({ url: 'pages/gitPage/list_loading' }, router.RouterMode.Single,
  //       error => {
  //         if (error) {
  //           console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
  //         }
  //       });
  //   }).margin(10)
  // }
}