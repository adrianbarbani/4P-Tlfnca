
/* ----------------------------------------------------------------------------------------------------
   BEGIN CORE CHATTER STYLES
   ---------------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------- */
/* Core photo and icon styles                                                        */
/* --------------------------------------------------------------------------------- */

.groupListPage .groupicon img,
.PeopleListPage .chatterlisticon img,
.searchResults .groupicon img,
.searchResults .chatterlisticon img,
.homeTab .bPageTitle .thumbnail_visible,
.feedcontainer .feeditemusericon,
.thumbnailPanel .thumbnailTable img,
.thumbnailPanel .groupThumbnail img,
.chatterListOverlay .overlayListPhoto img,
.followerIcon,
.feedcontainer .feeditemcommentphoto img,
.streamPhoto img.profilePhoto {
    border: 1px solid #D4DADC;
    display: block;
    overflow: hidden;
}

.groupListPage .groupicon img,
.PeopleListPage .chatterlisticon img,
.searchResults .groupicon img,
.searchResults .chatterlisticon img,
.homeTab .bPageTitle .thumbnail_visible,
.feedcontainer .feeditemusericon {
    height: 45px;
    width: 45px;
}

.thumbnailPanel .thumbnailTable img,
.thumbnailPanel .groupThumbnail img,
.chatterListOverlay .overlayListPhoto img,
.followerIcon,
.feedcontainer .feeditemcommentphoto img {
    width: 30px;
    height: 30px;
}
.thumbnailPanel .thumbnailTable.guests img {
    border-color: #F07E05;
}

.thumbnailPanel .groupThumbnail img.groupPrivateIcon,
.groupListPage .groupicon .groupPrivateIcon,
.searchResults .groupicon .groupPrivateIcon,
.overlayList.groupList .groupPrivateIcon,
.fileTypeIcon img.filePrivateIcon,
.overlayList img.groupPrivateIcon,
.sharedWithSummaryList img.groupPrivateIcon,
.chatterHover .groupPrivateIcon {
    background:#FFFFFF url(/img/chatter/private_group_icon.gif) no-repeat scroll 0 0;
    position: absolute;
    top: 19px;
    left: 20px;
    border-bottom: 1px solid #D4DADC;
    border-right: 1px solid #D4DADC;
    width: 11px;
    height: 12px;
}
.groupListPage .groupicon .groupPrivateIcon,
.searchResults .groupicon .groupPrivateIcon {
    top: 35px;
    left: 42px;
}

#shareWithEntityForm .chatterListOverlay .overlayListPhoto .groupPrivateIcon {
    top: -12px;
    left: 22px;
    position: relative;
}

/* --------------------------------------------------------------------------------- */
/* End Photo styles                                                                  */
/* --------------------------------------------------------------------------------- */

/* Feed Widget in Expandable/Collapsible Container  */

.expandoFeedContainer {
    background-color: #F3F3EC;
    clear: both;
    width: 100%;
}
.expandoFeedContainer .feedpage {
    padding-left: 10px;
    width: 817px;
}
.feedpage .feedmain {
    float:left;
    padding-bottom: 5px;
    width: 546px;
}
.feedpage .feedrightbar,
.feedpage .feedrightbarwider {
    float: right;
}

.feedpage .feedrightbar {
    width: 157px;
    padding: 15px 5px 30px;
    margin-right: 43px;
}

.feedpage .feedrightbarwider {
    width: 200px;
    padding-top: 15px;
    line-height: normal;
    white-space: normal;
}


/* Page Header Elements - User Image, User Name, Status, Status Controls */

.homeTab .bodyDiv .bPageTitle {
    padding-top: 5px;
}
.homeTab .bPageTitle .thumbnail_visible {
    float: left;
    margin-right: 10px;
}
.homeTab .bPageTitle .pageType {
    margin-bottom: 4px;
}
.homeTab .bPageTitle h1.currentStatusUserName {
    display: inline;
    padding-right: 4px;
}
.currentStatusUserName a {
    font-size: 0.72em;
    font-weight: normal;
}
.myCurrentStatus {
    font-weight: normal;
    font-size: 0.92em;
}
.subjectNameAndStatus {
	word-wrap: break-word;	
}
.userProfilePage .myCurrentStatus {
    font-size: 0.75em;
}
.chatterPage .currentStatusDot {
    display:inline;
}
.chatterPage .myCurrentStatusControls {
    display:block;
}
.myCurrentStatusControls {
    font-size:0.91em;
    font-weight: normal;
    line-height:1.1em;
}
.homeTab .myCurrentStatusControls {
    padding-left:7px;
    font-size: 0.85em;
    line-height:1.3em;
}
.homeTab .currentStatusLastUpdate {
    color:#7d7d84;
    margin-right:10px;
}

.currentStatusLastUpdate {
    white-space: nowrap;
    color: #b0b0b0;
}
.currentStatusDot {
    margin:0 4px;
    color:#9f9f9f;
    font-weight:700;
    font-size:1.465em;
    position:relative;
    top:-2px;
    display:none;
}

.actionsOnHoverEnabled .feeditemcomment{
    position:relative;
}

.actionsOnHoverEnabled .feeditembody {
    padding-right:40px;
}

.actionsOnHoverEnabled .bookmarkLink,
.actionsOnHoverEnabled .unbookmarkLink {
    background-image:url(/static/176/img/chatter/filters_sprite.png);
    width:16px;
    height:16px;
    display:block;
    text-indent:-999em;
    position:absolute;
    right:21px;
    top:2px;
    outline:none;
}
.actionsOnHoverEnabled .bookmarkLink {
    background-position:0 -280px;
}
.actionsOnHoverEnabled .unbookmarkLink {
    background-position:0 -264px;
}
.actionsOnHoverEnabled a.bookmarkLink:hover {
    background-position:0 -296px;
}
.actionsOnHoverEnabled a.unbookmarkLink:hover {
    background-position:0 -312px;
}
.actionsOnHoverEnabled .bookmarkLink .toolkit-el-mask,
.actionsOnHoverEnabled .unbookmarkLink .toolkit-el-mask {
    background-color: transparent;
}
.actionsOnHoverEnabled .feedDeleteLink,
.actionsOnHoverEnabled .commentDeleteLink {
    background-image:url("/img/feeds/x_sprite.png");
    width:9px;
    height:8px;
    display:block;
    border:4px solid #fff;
    text-indent:-999em;
    position:absolute;
    right:2px;
    top:0;
    outline:none;
}
.actionsOnHoverEnabled .commentDeleteLink {
    border:4px solid #eff7fa;
    top:2px;
}
.actionsOnHoverEnabled a.feedDeleteLink:hover,
.actionsOnHoverEnabled a.commentDeleteLink:hover {
    background-position:0 -8px;
}
.actionsOnHoverEnabled .bookmarkLink,
.actionsOnHoverEnabled .bookmarkDot,
.actionsOnHoverEnabled .feedDeleteLink,
.actionsOnHoverEnabled .commentDeleteLink,
.actionsOnHoverEnabled .deleteDot
{
    display:none;
}
.actionsOnHoverEnabled .feeditem:hover .bookmarkLink,
.actionsOnHoverEnabled .feeditem:hover .feedDeleteLink,
.actionsOnHoverEnabled .feeditemcomment:hover .commentDeleteLink {
    display:inline;
}
/* These styles are necessary to prevent an underline in RTL languages */
.actionsOnHoverEnabled .feeditem:hover .bookmarkLink,
.actionsOnHoverEnabled .feeditem:hover .unbookmarkLink,
.actionsOnHoverEnabled .feeditem:hover .feedDeleteLink,
.actionsOnHoverEnabled .feeditemcomment:hover .commentDeleteLink {
    text-decoration:none;
}

.feeditemextras .cxfeedcomment {
    padding-right:15px;
}

.feeditemextras {
    padding-right:20px;
}

.feedcontainer .feeditemlast {
    border-bottom: none;
}
.feedcontainer .feeditemseparatingdot {
    margin:0 3px;
}

/*feeditem*/
.feedcontainer .feeditemusericon {
    float: left;
}
.feedcontainer .feeditemcontent {
    display:block;
    margin-left: 58px;
    border-bottom:none;
}

.contentdetails {
    white-space: normal;
    word-wrap: break-word;
    table-layout: fixed;
    width: 100%;
}

.feedcontainer .feeditemcontent img.mruIcon,
.linkPostLinkContainer a.linkPostLink img {
    margin-right: 4px;
    vertical-align: middle;
}
.feedcointainer .feeditemcontentlink img {
    border: medium none;
}
.feedcontainer .feeditembodyandfooter {
    position: relative;
}
.feedcontainer .feeditemfooter,
.feedcontainer .feedcommentfooter {
    display:block;
    font-size: 0.92em;
    line-height: 13px;
    margin: 4px 0;
}
.feedcontainer .feeditemextras {
    margin: 3px 0 0 0;
}
.feedcontainer .feedArrow,
.feedcontainer .feeditemcomments{
    background: none;
    padding: 0;
    margin: 0;
    border-top:1px solid #dee4e9;
}
.feedcontainer .feedcommentarrow {
    height:5px;
    background: url(/img/alohaSkin/feeds/comment_topArrow.gif) no-repeat left top;
    margin-left:10px;
}

.feedcontainer .feeditemcomment,
.feedcontainer .feedcommentsshowmore,
.feedcontainer .feeditemcommentplaceholder,
.feedcontainer .feeditemlike {
    background: #eff7fa;
    border-bottom:1px solid #DEE5EA;
    border-top:1px solid white;
}
.feedcontainer .feeditemlike .like-icon, .feedcontainer .commentlike .like-icon{
    display:inline-block;
    height:15px;
    width:16px;
    margin-right:3px;
    background:url(/static/176/img/chatter/filters_sprite.png) 0 -181px;
}
.feedcontainer .commentlike .small-like-icon{
    background:url(/img/chatter/likesmall.png);
    display:inline-block;
    height:12px;
    width:12px;
    margin-right:6px;
}
.feedcontainer .feedcommentsshowmore{
    padding: 6px;
}
.feedcontainer .feeditemcomment,
.feedcontainer .feeditemcommentplaceholder,
.feedcontainer .feeditemlike {
    padding: 4px 6px;
}
.feedcontainer .feeditemcomment {
    min-height: 34px;
    padding-right:18px;
}
.feedcontainer .feeditemcomment a.feeditemcommentphoto {
    float:left;
}
.feedcontainer .feeditemcommentphotocontainer {
    height: 0;
}
.feedcontainer .feeditemcommentphoto img {
    float:left;
}
.feedcontainer .feeditemcommentaction {
    float: left;
    margin-right: 8px;
    border: 1px solid #999;
}
.feedcontainer .feeditemcommentbody {
    display: block;
    margin-left:42px;
}
.feedcontainer .feedcommentfooter {
    display:block;
}
.feedcontainer .feeditemextras .feeditemcommentplaceholder,
.feedcontainer .feeditemcommentnew {
    padding-right:15px;
}
.feedcontainer .feeditemcommentnew {
    margin-left:42px;
}
.feedcontainer .feeditemcommentnew .newcommentbutton {
    float:right;
    margin: 0 -10px 0 0;
}
.feedcontainer div.feeditemcommentnew .foobar {
    margin-bottom: 5px;
}
.feedcontainer .feeditemcommentplaceholder input {
    border:1px solid #C0D0D0;
    background:transparent url(/img/alohaSkin/feeds/textfield_bg80opacity.png) repeat-x scroll center top;
}
.feedcontainer .feeditemcommenttext textarea.foobar {
    background:#fff url(/img/alohaSkin/feeds/textfield_bg80opacity.png) repeat-x scroll center top;
}
.feedcontainer .singlefeeditemheader {
    padding:0 0 5px 0;
    margin:0 0 8px 0;
    line-height:28px;
    vertical-align:middle;
 }
 .feedcontainer .singlefeeditemheader .thisupdatespan {
     font-weight:bold;
     color:#222;
     background:#cfeef8;
     padding:6px;
     font-size:1.17em;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
 }
 .feedcontainer .singlefeeditemheader a {
     font-size:1.17em;
     font-weight:700;
     color:#015ba7;
     margin-right:9px;
 }
 .feedcontainer .singlefeeditemheader .thisupdatespanarrow {
     display:inline-block;
     height:28px;
     width:6px;
     margin-right:6px;
 }

 .feedcontainer .singlefeeditemheader .thisupdatespanarrowimage_ltr {
     background:url("/img/chatter/divider.png") 0 2px no-repeat;
 }

 .feedcontainer .singlefeeditemheader .thisupdatespanarrowimage_rtl {
     background:url("/img/chatter/divider_rtl.png") 0 2px no-repeat;
 }

.feedcontainer .feeditemtimestamp,
.feedcontainer .feeditemlinkpost,
.feedcontainer .feeditemclientinfo,
.feedcontainer .feeditemclientinfo a,
.feedcontainer .feeditemcomment .feeditemtimestamp:hover
{
    color: #7d7d84;
}
.feedcontainer .feeditemclientinfo {
    margin-left:4px;
}

.feedcontainer .feeditemtimestamp:hover {
    color:#015BA7;
}

.feedcontainer .feeditemlinkpost {
    padding-left: 20px;
}

.feedclearfloat {
    clear:both;
    height:0;
    font-size: .01em;
    line-height: 0px;
}
.feeddata {
    height:0;
    font-size:0;
    line-height: 0px;
}
.feedcontainer .linkPostLinkContainer {
    padding: 4px 0 5px 0;
}
.feedcontainer .linkPostLinkContainer a {
    font-size: 1.1em;
    font-weight: normal;
}

.feedcontainer .feedSearchHighlight {
    font-weight: bold;
    background-color: #FEF49B;
}

.feedcontainer a.feedMessageMentionSelfHighlight, /*All feed items in the feed */
body .bPageTitle .secondaryPalette span.statusContainer a.feedMessageMentionSelfHighlight, /* my status on home page*/
.userProfilePageSectionHeader a.feedMessageMentionSelfHighlight /*Status on the user profile page */ {
    background-color: #FEF49B;
}

.feedcontainer a.feedMessageLinkFont, /*All feed items in the feed */
body .bPageTitle .secondaryPalette span.statusContainer a.feedMessageLinkFont, /* my status on home page*/
.userProfilePageSectionHeader a.feedMessageLinkFont /*Status on the user profile page */ {
    color: #7D7D84;
}

.feedcontainer .feeditemcontent .trackedChangeRollover:hover {
    background-color: #EEEEEE;
}

/* --------------------------------------------------------------------------------- */
/* UI Toolkit styles to support Ext functionality                                    */
/* --------------------------------------------------------------------------------- */
.toolkit-el-mask {
    z-index: 100;
    position: absolute;
    top:0;
    left:0;
    -moz-opacity: 0.5;
    opacity: .50;
    filter: alpha(opacity=50);
    width: 100%;
    height: 100%;
    zoom: 1;
    background: #ccc;
}
.toolkit-masked {
    overflow: hidden !important;
}
.toolkit-masked-relative {
    position: relative !important;
}
.toolkit-masked select,
.toolkit-masked object,
.toolkit-masked embed {
    visibility: hidden;
}
/* --------------------------------------------------------------------------------- */
/* END: UI Toolkit styles to support Ext functionality                               */
/* --------------------------------------------------------------------------------- */

/* Shared */
.publishercontainer div.chattertextareaerror,
.feedcontainer div.feeditemcommentnew div.chattertextareaerror {
    border: 2px solid #ff1100;
    -moz-border-radius: 5px;
    border-radius: 5px;
}
.publishercontainer .publishererrorcontainer,
.feedcontainer .newcommenterrorcontainer {
    margin-bottom:6px;
    white-space: normal;
    background-color: #FFFCDD;
    -moz-border-radius: 5px;
    border-radius: 5px;
    border: 1px solid #f6eac1;
    width:100%;
    padding:4px;
}

.publishercontainer .publishererrorcontainer .errorHide,
.feedcontainer .newcommenterrorcontainer .errorHide{
    display:none;
}

.publishercontainer .publishererrorcontainer div,
.feedcontainer .newcommenterrorcontainer div {
    margin-bottom:3px;
    margin-left:6px;
    margin-top:3px;
}

.publishercontainer .publishererrorcontainer .publishererror,
.feedcontainer .newcommenterrorcontainer .publishererror {
    color: #ff1100;
}

.publishercontainer .publishererrorcontainer .publishernotice,
.feedcontainer .newcommenterrorcontainer .publishernotice {
    color: #222;
}

.feedcontainer .feeditemcommentplaceholder input, .feedcontainer .feeditemcommentnew .foobar,
.publishercontainer .publishertextarea {
    resize:none;
    margin:0;
    overflow: hidden;
    width:100%;
    background-color: #fff;
    border: 1px solid #c7ccce;
    padding: 4px;
    line-height: 16px;
    -webkit-line-break: after-white-space;  /* Specifies line-breaking rules for Chinese, Japanese, and Korean text */
    word-wrap: break-word; /*allows long words to be able to be broken and wrap onto the next line */
    outline-style:none;
    -moz-border-radius:5px;
    -webkit-border-radius: 5px;
}

.shadowDiv {
    -webkit-line-break: after-white-space;
    word-wrap: break-word;
}

.feedcontainer .feeditemcommentplaceholder input {
    color:#999999;
    height:1.3em;
    min-height:1.3em;
}
 .publishercontainer .publishertextarea {
    color:#999999;
    min-height:1.3em;
    background:transparent url(/img/alohaSkin/feeds/textfield_bg80opacity.png) repeat-x scroll center top;
 }

.feedcontainer .feeditemcommentnew .foobar,
.publishercontainer .publishertextareafocus {
    color:#222;
    background-color: #fff;
}

.publishercontainer .externalGroupInput {
    background: #FFF6E8;
}

.feedcontainer .feeditemcommenttext textarea.externalGroupInput {
    background: #FFF6E8;
}

.publisherInfoBox {
    -webkit-box-shadow: darkGray 0px 1px 7px;
    -moz-box-shadow: darkGray 0px 1px 7px;
    -moz-border-radius: 7px;
    border-radius: 7px;
    box-shadow: darkGray 0px 1px 7px;
    background: #FFFFFF;
    line-height: 15px;
    padding-top: 4px;
    padding-right: 4px;
    padding-bottom: 11px;
    padding-left: 16px;
    width: 380px;
    z-index: 100;
    position: absolute;
    font: #222;
    white-space: normal;
    border:1px solid #d4dadc;
}

td.publisherInfoBoxSyntaxKey {
    vertical-align:baseline;
    text-align:center;
    padding-right: 3px;
    padding-left: 10px;
}

td.publisherInfoBoxValue {
    padding:0px;
}

.publisherInfoBoxContent {
    padding-top: 4px;
}

.publisherInfoBoxSection {
    padding: 3px 0px;
}

span.publisherInfoLink, a.publisherInfoLink {
    color: #015ba7;
}

.publisherInfoBox .point.bottom {
    background-position:0px -45px;
    height:24px;
    width:40px;
    bottom:-12%;
    right:10%;
    margin-left:-20px;
    margin-bottom:-6px;
    position:absolute;
}

.publisherInfoBox .point {
    -moz-background-clip:border;
    -moz-background-inline-policy:continuous;
    -moz-background-origin:padding;
    background:url(/img/chatter/arrows_sprite_white.png) no-repeat scroll 0 0;
    position:absolute;
    z-index:-100;
}

.publisherInfoIcon {
    position: absolute;
    top: 14px;
    right: 14px;
    background:transparent url(/img/chatter/publisher_info_icon.png) no-repeat scroll 0 0;
    background-position:0px 0px;
    height: 20px;
    width: 20px;
    z-index:100;
    cursor: pointer;
}

.publisherInfoIcon.stickyHidden {
    display:none;
}

.publisherInfoIcon.active {
    background-position:0px -64px;
}

.publisherInfoIcon.hover {
    background-position:0px -32px;
}

#contentPublisherSlideDown .hidden {
    display: none;
}

#contentPublisherSlideDown .panel {
    background: transparent url(/img/alohaSkin/opacity50.png) repeat scroll center top;
    border: 1px solid #999999;
    margin: 0 -10px 6px 0;
}

#contentPublisherSlideDown .panelTitle {
    float: left;
    padding: 5px;
}

#contentPublisherSlideDown .panelHeader {
    padding-bottom: 29px;
    border-bottom: 1px solid #D7DBDE;
}

#contentPublisherSlideDown .closeButtonContainer {
    float : right;
    padding: 5px;
}

#contentPublisherSlideDown a.closeButton {
    background: transparent url('/img/alohaSkin/closeX.png');
    width : 20px;
    height : 20px;
    display : block;
    text-decoration: none;
}

#contentPublisherSlideDown  a.closeButton:hover {
    background-position: left -20px;
    text-decoration: none;
}

#contentPublisherSlideDown .contentPublisherTitle {
    margin-left : 7px;
    font-weight: bold;
    text-decoration: none;
    color: #000;
    line-height: 18px;
    font-size: 1.1em;
}

#contentPublisherSlideDown .contentPublisherTitleImage {
    background:transparent url(/img/feeds/publisher_icon16.png) no-repeat scroll left top;
    height: 16px;
    width: 16px;
}

#contentPublisherSlideDown .contentPublisherTitleImageFile {
    background-position:0 -16px;
    float: left;
}

#contentPublisherSlideDown .contentPublisherTitleImageLink {
    background-position:0 0;
    float: left;
}

#contentPublisherSlideDown table.postInput {
    margin: 0 auto 0 auto;
}

#contentPublisherSlideDown table.postInput td {
    padding-bottom: 10px;
}

#contentPublisherSlideDown table.postInput th {
    text-align: right;
    vertical-align: top;
    padding: 0 7px 0 0;
}

#contentPublisherSlideDown table.postInput label,
#contentPublisherSlideDown div.sharedWithOptionPanel label,
#chatterFileNewLabel_upload label {
    color: #4A4A56;
    font-weight: bold;
}

#contentPublisherSlideDown table.postInput input,
#contentPublisherSlideDown table.postInput textarea {
    background: #FFF none;
}

#contentPublisherSlideDown div.sharedWithOptionPanel {
    padding: 5px 24px 10px;
}

.fileFormInputElement {
    width: 292px;
}

.fileFormInputElementFullSize {
    width: 100%;
}

#contentPublisherSlideDown .requiredMark {
    color: white;
    display: inline;
}

#contentPublisherSlideDown .requiredLegend {
    float: right;
}

#contentPublisherSlideDown .requiredLegendContainer {
   height: 18px;
   font-size: 0.9em;
   margin-top: 5px;
   margin-right: 10px;

}

#contentPublisherSlideDown table.postInput textarea {
    overflow: auto;
}

#contentPublisherSlideDown .slideDownError {
    border : 1px solid #D74C3B;
    padding: 15px 15px 15px 50px;
    line-height : 16px;
    margin : 0 10px 10px 10px;
    background:#ffffcc url(/img/msg_icons/error24.gif) 14px 14px no-repeat;
    white-space: normal;
}

#contentPublisherSlideDown .requiredInput {
    height : 100%;
    position: relative;
}

#contentPublisherSlideDown .requiredInput .requiredBlock {
    background-color: #C00;
    position: absolute;
    left: -4px;
    width: 3px;
    top: 1px;
    bottom: 0;
}

#contentPublisherSlideDown .chatterPublisherActionsContainer {
    margin : auto;
    padding : 0;
}

#contentPublisherSlideDown .chatterPublisherActionsContainer td.chatterPublisherFileActionContainerLeft {
    margin-right : -1px;
    border-right: 1px solid #D7DBDE;
}

#contentPublisherSlideDown .chatterPublisherActionsContainer td {
    width : 50%;
    text-align : center;
    font-size: 1.1em;
    padding : 17px 0;
    text-decoration: none;
    white-space: normal;
}

#contentPublisherSlideDown .chatterPublisherActionsContainer {
    width: 100%;
}

#contentPublisherSlideDown .chatterPublisherActionsContainer td:hover {
    text-decoration: underline;
    background: #E2F2FF;
}

#contentPublisherSlideDown a {
    text-decoration: none;
    color: #015BA7;
}

#contentPublisherSlideDown a:hover {
    text-decoration: underline;
}

#contentPublisherSlideDown .linkedContentDetailsContainer {
    margin: 10px;
    padding: 10px 0 0 0;
    overflow: hidden;
}

.linkedContentDetailsContainer .previewContainer {
    padding: 0 5px 5px;
    float:left;
}

.linkedContentDetailsContainer .title {
    overflow: hidden;
    white-space: normal;
    padding: 0 5px 5px 0;
    font-weight: bold;
    font-size: 1.1em;
}

.linkedContentDetailsContainer .action {
    padding: 0 0 5px 7px;
    overflow: hidden;
    white-space: normal;
}

.linkedContentDetailsContainer .description {
    display: block;
    overflow: hidden;
    white-space: normal;
    padding: 5px 0;
}

.feeditemcomment .contentPost .rightSideCell {
    padding- left: 2px;
}

.feeditemcomment .contentPost .rightSideCell .img {
    margin: 0;
}

.feeditemcomment img.contentThumbnail {
    /* The thumbnail can be displayed landscape or portrait, this scales it to half-size */
    max-width: 60px;
    max-height: 60px;
    padding: 0;
}

.feeditemcomment img.contentThumbnailNoPreview {
    margin: 0 7px 0 10px;
}

.feeditemcomment .contentPost .rightSideCell {
    padding- left: 2px;
}

.feeditemcomment .cxcontentcommentinfo {
    width: 300px;
}

.feeditemcomment .linkedContentDetailsContainer .previewContainer {
    padding: 0;
    max-width: 60px;
}

.feeditemcomment .linkedContentDetailsContainer img.contentThumbnail {
    margin: 0;
}

.feeditemcomment .linkedContentDetailsContainer img.contentThumbnailNoPreview {
    margin: -4px 0 0;
}

.feeditemcomment .linkedContentDetailsContainer .contentdetails {
    float: left;
    max-width: 230px;
    padding: 0 0 0 9px;
    margin-top: -2px;
}

.feeditemcomment .linkedContentDetailsContainer .title {
    font-size: 1em;
    white-space: normal;
    word-wrap: break-word;
}

.feeditemcomment .linkedContentDetailsContainer .action {
    display: block;
    padding: 0;
}

.feeditemcomment .contentDescription,
.feeditemcomment .linkedContentDetailsContainer .description {
    display: none;
}

.clearBoth {
    clear : both;
}


#chatterFindExistingContentContent .helpLinkContainer {
    float: right;
}

#chatterFindExistingContentContent .helpLink {
    vertical-align: top;
    padding-right: 5px;
}

#chatterFindExistingContentContent iframe {
    overflow: hidden;
}

.chatterFileListBlock a.tipsLink:hover span.helpLink,
.chatterFileListBlock a.fileNameLink:hover {
    text-decoration: underline;
}

#chatterFindExistingContentContent .quickfindContainer {
    float: left;
    padding-top: 0;
}

.detailPage .feedpage .feedmain {
    line-height:16px;
}
.cxshowmorefeeditemscontainer a {
    margin-top:12px;
    font-size:0.92em;
    font-weight:700;
    color:#333;
    text-decoration:none;
    display:block;
    border:1px solid #D4DADC;
    text-align:center;
    padding:4px 0;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    text-decoration:none;
    background: url("/img/alohaSkin/btn_sprite.png") repeat-x scroll right top #E8E8E9;
}
.cxshowmorefeeditemscontainer a:hover {
    text-decoration:none;
    color:#333;
    background-position:right -30px;
}
.cxshowmorefeeditemscontainer a:active {
    background-position:right -60px;
}
/** video link style **/
.videoLinkPostOuterContainer {
    padding: 4px 0px 5px;
    position: relative;
}
.videoImages {
    position: relative;
    width: 140px;
    height: 97px;
    float: left;
}
.videoLinkPostOuterContainer iframe{
    z-index: 1;
}
.videoImages .thumbnail {
    padding-right: 10px;
    position: absolute;
    top: 0;
    left: 0;
    height: 97px;
    width: 130px;
    cursor: pointer;
}
.videoImages .play {
    background: url(/img/chatter/play.png) no-repeat scroll 0 0 transparent;
    width: 70px;
    height: 50px;
    position: absolute;
    margin-top: -23px;
    margin-left: -35px;
    top: 50%;
    left: 50%;
    cursor: pointer;
}
.videoLinkPostContainer > div.clear {
    clear: both;
}
.videoLinkMetaClass {
    word-wrap: break-word;
    overflow: hidden;
}
.videoLinkMetaClass > .videoLinkPostLinkTitle {
    color: #015BA7;
    font-weight:normal;
    font-size: 1em;
    padding-bottom: 5px;
}
.videoLinkMetaClass > .videoLinkDescription {
    color: #7d7d84;
    font-weight:normal;
    font-size: 1em;
    line-height: 15px;
    padding-bottom: 5px;
}
.videoLinkMetaClass > .videoLinkLengthClass {
    color: #222222;
    font-weight:normal;
    font-size: 1em;
    line-height: 15px;
}
/**end: video link style**/
/* --------------------------------------------------------------------------------- */
/* End Chatter Feed                                                                  */
/* --------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------- */
/* BEGIN: External User views other user profile                                     */
/* --------------------------------------------------------------------------------- */

.guestUserMessage {
    background:#fff url(/img/alohaSkin/feeds/feedbg.png) repeat-x scroll left -40px;
    padding:15px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    -moz-box-shadow: 0 2px 4px #aaa;
}
.guestUserMessageHeader {
    font-size:1.2em;
    padding:5px;
    font-weight: bold;
    color:#222;
}
.guestUserMessageContent {
    font-size:1.0em;
    padding:5px;
    padding-left:50px;
    color:#222;
}
.guestUserMessageFooter {
    font-size:1.0em;
    padding:5px;
    padding-left:50px;
    color: #008040;
}
.guestUserMessage .lockIcon {
    background: url("/img/chatterservice/lock24.png") no-repeat;
    padding-left: 35px;
    padding-right: 0px;
    padding-top: 11px;
    padding-bottom: 11px;
}
.guestUserMessage .signUpButton {
    background: #e8e8e9 url('/img/chatter/btnGreen_bg.png') repeat-x right top;
    font-size: 108%;   /* 13px */
    font-weight: bold;
    color: #FFFFFF;
    margin-left: 5px;
}
.guestUserMessage .signUpButton:hover{
    background: none repeat scroll 0 0 #62B61B;
}

/* --------------------------------------------------------------------------------- */
/* END: External User views other user profile                                       */
/* --------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------- */
/* BEGIN: Live Feeds                                                                 */
/* --------------------------------------------------------------------------------- */

.feedcontainer .newFeedItemsMessage {
    background-color: #ffffdc;
    border-color: #fceeb4;
    border-style:solid;
    border-width:1px;
    color:#000000;
    cursor: pointer;
    line-height: 23px;
    margin: 4px 3px 20px 0px;
    padding: 0 14px;
    whitespace: normal;
    -moz-border-radius:5px 5px 5px 5px;
    text-align:center;
}

.feedcontainer .newFeedItemsMessageHover {
    border-color: #e9eded;
    background:url(/img/chatter/feedupdate_bgGradient.png) repeat-x scroll 0 0;
}

.feedcontainer .newFeedItemsMessage a {
    cursor: pointer;
}

/* --------------------------------------------------------------------------------- */
/* END: Live Feeds                                                                   */
/* --------------------------------------------------------------------------------- */

.vfButtonBar {
    position: relative;
    background-color:transparent;
    border-bottom:1px solid #D7DBDE;
    line-height:20px;
    margin: 0 0 7px;
}

.vfButtonBar a {
    color:#015BA7;
    font-size:0.9em;
    text-decoration:none;
    float: right;
}
.vfButtonBar a:hover {
    text-decoration: underline;
}

.vfButtonBarButton {
    position: absolute;
    right: 5px;
    top: 1px;
}
.userProfilePage .vfButtonBar h3,
.feedpage .vfButtonBar h3,
h3.topicWidgetHeader.mostUsedTopicHeader {
    font-size: 1.0em;
    color: #333435;
}
/* --------------------------------------------------------------------------------- */
/* START FeedWithFollowersElement Styles: Home and Entity Detail Pages               */
/* --------------------------------------------------------------------------------- */
.chatterexpando {
    border: transparent;
    -moz-border-radius-bottomleft: 5px;
    -moz-border-radius-bottomright: 5px;
    -webkit-border-bottom-right-radius: 5px;
    -webkit-border-bottom-left-radius: 5px;
    border-top: 1px solid #fff;
    background:#fff url(/img/alohaSkin/feeds/feedbg.png) repeat-x scroll left -40px;
    width:100%;
}
.chatterexpando .feedpage {
    padding-left:10px;
    width:760px;
}

/* --------------------------------------------------------------------------------- */
/* END FeedWithFollowersElement Styles: Home and Entity Detail Pages               */
/* --------------------------------------------------------------------------------- */


/* --------------------------------------------------------------------------------- */
/* START Content's Publisher Styles                                                  */
/* --------------------------------------------------------------------------------- */
.docViewerOverlay .innerContent {
    padding:4px 4px 0;
}
a:hover .contentContainer {
    text-decoration: none;
}
a:hover .contentActionLabel,
a:hover .contentTitleLink {
    text-decoration: underline;
}
.feedcontainer a.contentActionLink:hover {
    text-decoration: none;
}
.feedcontainer a.contentActionLink:hover span.contentActionLabel {
    text-decoration: underline;
}

.feedcontainer .contentActionLabel {
    padding: 2px;
}
.feedcontainer a.contentActionLink img {
    height: 16px;
    width: 16px;
    background: transparent url(/img/chatterfiles/chatterfiles16_sprite.png) no-repeat;
}
.feedcontainer a.contentActionLink .previewItemIcon,
.feedcontainer a.contentActionLink .openUrlItemIcon {
    background-position: 0  -2px;
}
.feedcontainer a.contentActionLink .downloadItemIcon {
    background-position: 0  -20px;
}

.feedcontainer a.contentActionLink .uploadIcon {
    background-position: 0  -40px;
}

.feedcontainer a.contentActionLink .publishItemIcon {
    background-position: 0  -405px;
}

.feedcontainer a.contentActionLink .shareItemIcon {
    background-position: 0  -56px;
    vertical-align: middle;
    /*position: relative;
    top: 1.5px;*/
}
.feedcontainer span.fileSize,
.postInput span.fileSize {
    color: #666
}

.postInput div.uploadFileSizeLimit {
    padding-top: 4px;
}

.contentPost .moreFileActions-td .chatterFollowUnfollow {
    font-size:0.9em;
}

.contentPost .moreFileActions-td .linkText,
.contentPost .moreFileActions-td .contentActionLabel {
    vertical-align: baseline;
}

.contentPost .moreFileActions-td .followicon {
    margin-top: -2px;
}

.contentPost .moreFileActions-td .followLink,
.contentPost .moreFileActions-td .unfollowLink {
    display: inline;
    vertical-align: baseline;
}

.contentActionMenu {
    border-radius: 5px;
    -moz-border-radius: 5px;
    -moz-box-shadow: 0 2px 5px #A0ACAB;
    -webkit-border-radius: 5px;
    -webkit-box-shadow: 0 2px 5px #A0ACAB;
    display: none;
    background-color: #FFFFFF;
    padding-top: 5px;
    padding-bottom: 5px;
    padding-left: 13px;
    padding-right: 5px;
    position: absolute;
    z-index: 5;
    border: 1px solid #B6B6B6;
}


.feedcontainer a.cxcontentcommentaction:hover {
    text-decoration: none;
}


#contentCommentDropdown  {
    border-radius: 5px;
    -moz-border-radius: 5px;
    -moz-box-shadow: 0 2px 5px #A0ACAB;
    -webkit-border-radius: 5px;
    -webkit-box-shadow: 0 2px 5px #A0ACAB;
    background-color: #FFFFFF;
    padding-top: 5px;
    padding-bottom: 5px;
    padding-left: 5px;
    padding-right: 5px;
    border: 1px solid #B6B6B6;
    z-index: 5;
}

#contentCommentDropdown   .contentCommentMenuItem {
    margin-top: 1px;
    margin-bottom: 1px;
    padding-left: 5px;
    padding-right: 5px;
}

#contentCommentDropdown  .contentCommentMenuItem:hover {
    border-radius: 9px;
    -moz-border-radius: 9px;
    -webkit-border-radius: 9px;
    background-color: #cfeef8;
    height: 23px;
}

#contentCommentDropdown  .contentCommentMenuItem {
    font-size: 1em;
    line-height: 23px;
    font-weight: normal;
}

#contentCommentDropdown .contentCommentMenuItem a {
    text-decoration:none;
    color: #015BA7;
}

 #contentCommentDropdown .contentCommentMenuItem a:hover {
    text-decoration:none;
    color: #015BA7;
}

.contentActionMenuItem .contentActionLabel{
    font-size: 1em;
    line-height: 23px;
    padding: 0px 5px;
}

.contentActionMenuItem > .contentActionLink {
    white-space: nowrap;
    text-decoration: none;
}

.contentActionMenuItem > .contentActionLink > img {
    margin-top: 4px;
}



.contentActionMenu > .upload.hover {
    border-top: none;
}

.contentActionMenu > .hr {
    margin-left: -9px;
    border-top: 1px solid #d4dadc;
}

.contentActionMenu .noIcon{
    padding-left: 19px;
}

.contentActionMenu .noIcon > .contentActionLabel {
    vertical-align: middle;
}

.feedcontainer .contentActionMenu .contentActionLink:hover > .contentActionLabel {
    text-decoration: none;
}

.feedcontainer .contentActionMenu > .hr > .noIcon > .contentActionLink:hover > .contentActionLabel {
    text-decoration: underline;
}

.more-file-actions > .contentActionLabel {
    padding-right: 5px;
    vertical-align: baseline;
}

.more-file-actions > .content-action-link-arrow,
.chatterFileDetailActionListPanel .content-action-link-arrow {
    background: transparent url(/img/feeds/arrow_sprite.png) no-repeat scroll 0 -14px;
    height: 9px;
    width: 9px;
    vertical-align: baseline;
    margin-bottom: -2px;
}

.chatterFileDetailActionListPanel .content-action-link-arrow {
    margin-bottom: 3px;
    margin-left: 5px;
}

.contentActionMenu .chatterFollowUnfollow {
    display: block;
}

.more-file-actions:hover > .content-action-link-arrow,
.chatterFileDetailActionListPanel:hover .content-action-link-arrow {
    background-position: 0 -22px;
}

.more-file-actions:hover {
    text-decoration: none !important;
}

.contentActionMenuItem {
    margin-top: 1px;
    margin-bottom: 1px;
    margin-left: -9px;
    padding-left: 8px;
}

.hr > .contentActionMenuItem {
    margin-left: 0;
}

.contentActionMenuItem.hover {
    border-radius: 9px;
    -moz-border-radius: 9px;
    -webkit-border-radius: 9px;
    background-color: #cfeef8;
    height: 23px;
}

.contentActionMenu .unchecked,
.contentActionMenu .disabled,
.contentActionMenu .inverification {
   display: none;
}


.contentActionMenu a.unchecked:hover span.contentActionLabel,
.contentActionMenu a.disabled:hover span.contentActionLabel  {
   text-decoration: none;
   cursor: default;
}

.contentThumbnail-a:hover > .contentThumbnail {
    border: 1px solid #015ba7;
    padding: 0;
}

.contentThumbnail-a > .contentThumbnail {
    padding: 0;
}

.contentThumbnail-a {
    display: block;
    height: 100%;
}

.contentThumbnail + .previewHover {
    background-image: url(/img/chatterfiles/zoom24withbg.png);
    background-position: center center;
    background-repeat: no-repeat;
}

.feeditemcomment .contentThumbnail + .previewHover {
    background-image: url(/img/chatterfiles/zoom12withbg.png);
}

.feeditemcomment .linkedContentDetailsContainer .contentThumbnail + .previewHover {
    margin-top: 0;
}

/* --------------------------------------------------------------------------------- */
/* END Content's Publisher Styles                                                    */
/* --------------------------------------------------------------------------------- */

/* Ext-Core Styles */

/* Used for File Upload */
iframe.x-hidden {
    position:absolute !important;
    left:-10000px;
    top:-10000px;
    visibility:hidden;
}

/* END Ext-Core Styles */

/* chatter user hover overlay */

body .userProfileHoverUserBlock .userProfileHoverPageBlock .userProfileHoverBody.pbBody.chatterUserProfileHoverBody {
    padding: 16px;
    margin: 0;
}

.chatterUserProfileHoverCol1 {
    width: 64px;
    float: left;
    margin-right: 14px;
}

.chatterUserProfileHoverPhoto img {
    width: 64px;
    height: 64px;
}

.chatterUserProfileHoverCol2 {
    float: left;
}

.chatterUserHoverName a {
    font-size:1.67em;
    color: #014BA7;
    font-weight: bold;
    text-decoration: none;
}

.chatterUserHoverTitle {
    font-size: 1em;
    color: #7d7d84;
    font-style: italic;
}

.chatterUserHoverPhoneList {
    margin-top: 10px;
    line-height: 16px;
}

.chatterUserHoverPhoneLine {
    font-size: 1em;
}

.chatterUserHoverPhoneNumber {
    color: #222;
    float:left;
    margin-right:8px;
}

.chatterUserHoverPhoneType {
    color: #7d7d84;
}

.chatterUserHoverTool {
    padding-top: 8px;
    margin-top: 8px;
    border-top: 1px solid #e9eaea;
}


/* END chatter user hover overlay */

/* for external users, guestBadge style - */
.chatterUserGuestBadge, .chatterGroupGuestBadge, .nonTailBreadCrumbGuestBadge {
    display: inline-block;
    color: #ffA500;
    margin-left: 5px;
    font-weight: normal;
    *display: inline;
}

/**
*The display style needs to be overrided on PeopleListPage so that the Customer label is considered inline to the name text
*and the overflow text will consider (Customer) label as well.*/
.PeopleListPage .chatterUserGuestBadge {
    display: inline;
}

.nonTailBreadCrumbGuestBadge{
    margin-left: 0px;
    margin-right: 5px;
}

/**
* start chatter hover styles
*
* The reason there are a lot of !important is
* because these hovers are placed in multiple places in the dom
* for accessibility reasons so if we don't use !important the
* styles will be overridden.*/
.chatterHover {
    position: relative;
    font-weight: normal;
    line-height: 14.4px;
}

.mruList .hov-enable.highlight {
    background-color: #E3F3FF;
    -moz-border-radius: 5px;
    border-radius: 5px;
}

.chatterHover.right {
    /** there should be NO } here */
    padding-left: 11px;
}

.chatterHover.left {
    /** there should be NO } here */
    padding-right: 11px;
}

.chatterHover.above {
    padding-bottom: 11px;
}

.chatterHover.below {
    padding-top: 11px;
}

.chatterHover > .arrow {
    background:transparent url(/img/chatter/dialogbox_arrows.png) no-repeat scroll left top;
    position: absolute;
    width: 25px;
    height: 25px;
}

.chatterHover.above > .arrow {
   background-position: -4px -34px;
   bottom: 0;
   left: 13px;
}

.chatterHover.below > .arrow {
    background-position: 0 -243px;
    left: 13px;
    top: 0;
}

.chatterHover.right > .arrow {
    background-position: -25px -85px;
    /** there should be NO } here */
    left: 0;
    top: 0;
}

.chatterHover.left > .arrow {
    background-position: 11px -2px;
    /** there should be NO } here */
    right: 0;
    top: 0;
}

.chatterHover > .wrapper {
    border: 1px solid #B6B6B6;
    margin: 0;
    background-color: #FFF;
    -moz-border-radius: 5px;
    border-radius: 5px;
    -moz-box-shadow: 0 2px 5px #A0ACAB;
    box-shadow: 0 2px 5px #A0ACAB;
    padding: 14px;
    position: relative;
    overflow: hidden; /* W-1033512 auto; */
    min-width: 272px;
    min-height: 35px;
    white-space: normal; /* W-1033512 nowrap; */
}

.chatterHover.right > .wrapper, .chatterHover.left > .wrapper {
    top: -20px;
}

.chatterHover .loadHover {
    background: url("/img/loading.gif") no-repeat scroll 0 2px transparent;
    height: 38px;
    padding-top: 3px;
    text-indent: 20px;
}

.chatterHover .hoverInfo {
    padding-bottom: 1px;
    margin-left: 12px;
    word-wrap: break-word;
    float: left;
    /* min-width wrapper = 271px
       width mage = 46px
       margin: 14px -> max-width: 211px */
    max-width: 211px;
    width: 210px;
    overflow: hidden;
    white-space: normal;
}

.chatterHover .hoverInfo > .nameAndInfo {
    margin-bottom: 10px;
    max-width: 210px;
}

.chatterHover .thumbHover {
    float: left;
    border: 1px solid #d4dadc;
    width: 45px !important;
    height: 45px !important;
}

.chatterHover > .wrapper > a.thumbnailLink {
    display: block !important;
    position: relative;
}

.chatterHover .groupPrivateIcon {
    top: 36px;
    left: 37px;
}

.chatterHover .thumbHover.guest {
    border-color: #F07e05;
}

.chatterHover .thumbHover.file {
    width: auto !important;
    height: auto !important;
    border: none;
}

.chatterHover .thumbHover.file.loading {
    background: url("/img/loading.gif") no-repeat scroll 10px 10px transparent;
    width: 32px !important;
    height: 32px !important;
}

.chatterHover .chatterFileDetailActionListPanel > ul {
    padding: 0;
    margin: 0;
}

.chatterHover .hoverInfo > .hoverData {
    font-size: 1em;
}

.chatterHover .hoverInfo > .hoverData > .detail {
    color: #7d7d84;
}

.chatterHover .hoverInfo > .nameAndInfo > .name,
.chatterHover .hoverInfo > .nameAndInfo > .nameDiv > .name {
    font-size: 1.2em;
    color: #015BA7;
    font-weight: bold;
    text-decoration: none;
}

.chatterHover .hoverInfo > .withPresence > .name,
.chatterHover .hoverInfo > .withPresence > .nameDiv {
    max-width: 190px;
    display: inline-block;
    float: left;
}

.chatterHover .hoverInfo > .withPresence > .chatStatus {
    float: left;
}

.chatterHover .hoverInfo > .nameAndInfo > .title,
.chatterHover .hoverInfo > .nameAndInfo > .company,
.chatterHover .hoverInfo > .misc {
    color: #7d7d84;
    padding-botton: 10px;
}

.chatterHover .hoverInfo > .nameAndInfo > .title,
.chatterHover .hoverInfo > .nameAndInfo > .company {
    font-style: italic;
}

.chatterHover .hoverInfo > .misc {
    font-style: normal;
    line-height: 1.2em;
}

.chatterHover .hoverInfo .date {
    white-space: nowrap;
    color: #7D7D84 !important;
}

.chatterHover .hoverInfo > .description {
    margin-top: 15px;
}

.chatterHover .actions {
    padding-top: 4px;
    margin-top: 10px;
    border-top: 1px solid #e9eaea;
    width: 210px;
    white-space: nowrap;
}

.chatterHover .actions.file ul > li {
    margin: 0 !important;
    padding: 0 !important;
}

.chatterHover .followLink,
.chatterHover .unfollowLink {
    padding: 2px 0 !important;
}

/**
* Bug fix W-1020065
*/
.chatterHover .actions.user > .chatterFollowUnfollow .linkText {
    margin-left: 4px;
}

.chatterHover .actions.file > .chatterFollowUnfollow {
    display: block;
    padding-bottom: 2px;
}

.chatterHover .asktojoin {
    text-decoration: none;
}

.chatterHover .sendPrivateMessage > a {
    text-decoration: none;
    font-size: 1em;
    color: #015ba7;
    font-weight: normal !important; /* W-1024067 */
}

.chatterHover .message {
    margin: 10px 0 0;
    padding-top: 10px;
}

.chatterHover .actions > a {
    text-decoration: none;
    font-size: 1em;
    color: #015ba7;
}

.chatterHover .unfollowicon,
.chatterHover .followicon {
    width: 15px !important;
    height: 15px !important;
}

.chatterHover .groupmanagementlink {
    padding-top: 0 !important;
    padding-bottom: 0 !important;
}

.chatterHover .chatIcon {
    background: transparent url(/img/chatter/chat16.png) no-repeat scroll left top;
    width: 19px !important;
    height: 16px !important;
    vertical-align: middle;
    margin-left: 1px;
    margin-right: -1px;

}

.chatterHover .chatLabel {
    margin-left: -1px;
}

.chatterHover .offline .chatIcon {
    background: transparent url(/img/chatter/chatoffline_16.png) no-repeat scroll left top;
}

.chatterHover .away .chatIcon {
    background: transparent url(/img/chatter/chataway_16.png) no-repeat scroll left top;
}

/**
* have to use this img selector because else it will be overriden
*/
.chatterHover .hoverInfo img {
    display: inline;
    border: none;
}

.chatterHover .chatStatus {
    background: url(/img/chatter/statusIcons.png)  no-repeat scroll 0 0 transparent;
    width: 16px !important;
    height: 15px !important;
    vertical-align: bottom !important;
}

.chatterHover .offline {
    background-position: 0 -32px;
}

.chatterHover .online {
    background-position: 0 0.5px;
}

.chatterHover .away {
    background-position: 0 -16px;
}

.chatterHover .profileSection {
    margin: 0;
}

.chatterHover .actions .chat {
    display: block;
    color: #015ba7;
    text-overflow: ellipsis;
    overflow: hidden;
}

/** this has to be duplicated here with important because else it is overriden */
.chatterHover .sendPrivateMessage img {
    width: 19px !important;
    height: 16px !important;
}

.chatterHover .actions .chat:hover > .chatLabel {
    text-decoration: underline;
    cursor: pointer;
}

.chatterHover .actions .offline {
    color: #7d7d84;
}

.chatterHover .actions .offline:hover > .chatLabel {
    cursor: default;
    text-decoration: none;
}

/* Fix for W-1137763*/
.chatterHover .wrapper .pbBody  a {
	color: #000;
}


    /**
    * Chatter File Hovers
    */
    .chatterFileDetailActionListPanel li a,
    .chatterFileDetailActionListPanel li a:hover {
        color: #015ba7;
        text-decoration: none;
    }

    .chatterFileDetailActionListPanel img {
        background: transparent url(/img/chatterfiles/chatterfiles16_sprite.png) no-repeat;
    }

    .chatterFileDetailActionListPanel ul {
        list-style: none;
        padding-top:9px;
        padding-bottom:4px;
    }

    .chatterFileDetailActionListPanel li {
        margin: 4px 0 4px 0;
        min-height: 16px;
    }

    .chatterFileDetailActionListPanel li a:hover span {
        text-decoration: underline;
    }

    .chatterFileDetailActionListPanel .actionLabel {
        vertical-align:top;
        white-space:nowrap;
        margin-left: 3px;
    }

    .chatterFileDetailActionListPanel .fileSizeLabel {
        vertical-align:top;
        color: #7d7d84;
        font-size: 0.9em;
    }

    .chatterFileDetailActionListPanel img {
        height: 16px;
        width: 16px;
    }

    .chatterFileDetailActionListPanel .downloadItemIcon {
        background-position: 0  -20px;
    }



    .chatterFileDetailActionListPanel .shareFileWithItemIcon {
        background-position: 0 -56px;
    }

    .chatterFileDetailActionListPanel .updateVersionItemIcon {
        background-position: 0 -38px;
    }

    .chatterFileDetailActionListPanel .publishItemIcon {
        background-position: 0 -405px;
    }

    /* styles for using mini page layout in hovers */

    .chatterHover .bPageBlock {
        margin: -14px;
        background-color: #FFF !important;
        width: 370px;
        /*overflow-y: auto; */ /* we may want to remove this comment if the other fixes does not work W-1099301 */
    }

    .chatterHover .pbBody table {
    	table-layout: fixed; /* W-1099301 */
    	word-wrap: break-word; /* W-1099301 */
    }

    .chatterHover .pbBody {
        background-image: none !important;
    }


/**
end chatter hover styles
*/
/**
start direct message link styles
*/
.sendPrivateMessage a:hover {
    text-decoration: none;
}
.sendPrivateMessage a:hover span {
    text-decoration: underline;
}
.sendPrivateMessage img {
    background: transparent url(/img/chatter/messages16.png) no-repeat scroll left top;
    width: 19px;
    height: 16px;
    vertical-align: middle;
}

/**
end direct message link styles
*/

/* ------------------------Dashboard Gauge Snapshots BEGIN   ----------------------- */

.feedcontainer .dbrdCmpLabel {
    padding: 2px;
    font-size: 0.92em;
}

.feedcontainer a.dbrdCmpViewLink img {
    height: 16px;
    width: 16px;
    background-repeat: no-repeat;
    background-color: transparent;
    background-position: 0  -2px;
    background-image: url(/img/chatterfiles/chatterfiles16_sprite.png);
}

.feedcontainer img.dbrdThumbnail {
    width: 140px;
    border: 1px solid transparent;
}

.dbrdThumbnail-a:hover > .dbrdThumbnail {
    border: 1px solid #015ba7;
    padding: 0;
}
.dbrdThumbnail-a > .dbrdThumbnail {
    padding: 0;
}

.dbrdThumbnail-a {
    display: block;
    height: 100%;
    position: relative;
}

.dbrdThumbnail + .previewHover {
    background-image: url(/img/chatterfiles/zoom24withbg.png);
    background-position: center center;
    background-repeat: no-repeat;
    top: 0;
    left: 1px;
    margin-top: 4px;
    padding: 0;
    position: absolute;
}


.dbrdSnapshotDialog .middle .innerContent {
    height: auto;
    max-height: 580px;
    overflow: auto;
}

.dbrdSnapshotDialog {
    width: auto;
}

.dbrdThumbnailPreview {
    width: auto;
}

.dbrdThumbnailSubtitle {
    font-size: 0.92em;
    color: #7D7D84;
}

.dbrdThumbnailCmpTitle {
    font-weight: bold;
}

.feedcontainer a.dbrdCmpViewLink:hover {
    text-decoration: none;
}
.feedcontainer a.dbrdCmpViewLink:hover span.dbrdCmpLabel {
    text-decoration: underline;
}

.feedcontainer a.dbrdCmpGotoDashLink img {
    height: 16px;
    width: 16px;
    background-repeat: no-repeat;
    background-color: transparent;
    background-position: 0 -325px;
    background-image: url(/img/chatterfiles/chatterfiles16_sprite.png);
}

.feedcontainer a.dbrdCmpGotoDashLink:hover {
    text-decoration: none;
}

.feedcontainer a.dbrdCmpGotoDashLink:hover span.dbrdCmpLabel {
    text-decoration: underline;
}

/* -----------------------Dashboard Gauge Snapshots END --------------------------- */

/* --------------------------------------------------------------------------------- */
/* Overlay Styles.  ie: Followers, Following, Change Group Roles, etc.               */
/* --------------------------------------------------------------------------------- */
.chatterListOverlay {
    background: transparent;
}
.chatterListOverlay table {
    font-size: 1.0em;
}
.chatterListOverlay .filterBy {
    color: #4a4a56;
    font-size: 1em;
    font-weight: bold;
    margin-right: 2px;
}
.chatterListOverlay .overlayList {
    overflow-y: auto;
    overflow-x: auto;
    height: 325px;
    margin-top: 10px;
    position: relative;
}
.chatterListOverlay .titleSpan {
    color: #4a4a56;
    font-size: 0.9em;
}
.chatterListOverlay .boldTitleSpan {
    font-weight: bold;
}
.chatterListOverlay select {
    font-size: 0.9em;
}
.chatterListOverlay .cancelButton,
.modalOverlay .buttonBar {
    text-align: center;
}
.chatterListOverlay .displayName {
    overflow:hidden;
    text-overflow:ellipsis;
    width:280px;
    white-space: nowrap;
}
.chatterListOverlay .entityDisplayName {
    width: 350px;
    padding-top: 8px;
    padding-bottom: 8px;
}
.chatterListOverlay .entitySelect,
.entitySelect option {
    width: 100px;
}
.chatterListOverlay .overlayListTable td {
    border-bottom: 1px solid #ededed;
    vertical-align:top;
}
.chatterListOverlay .overlayListPhoto {
    width:36px;
    padding-right: 10px;
}
.chatterListOverlay .overlayListName {
    padding-left: 0px;
}
.chatterListOverlay .entityTable .overlayListName {
    vertical-align: middle;
}
.chatterListOverlay .overlayListLink {
    white-space: nowrap;
}

.chatterListOverlay .overlayList {
    border-top: 1px solid #dbdbdb;
    border-bottom: 1px solid #dbdbdb;
}
.chatterListOverlay .paginator {
    text-align: right;
    margin-top: 6px;
}

.chatterListOverlay .paginator.withExternalInvite {
    position: absolute;
    right: 15px;
}

.chatterListOverlay .subscribeLinkErrors {
    white-space: normal;
}
.chatterListOverlay .externalInvite {
    margin-top: 6px;
    margin-bottom: 10px;
    padding-left: 40px;
    background: transparent url(/img/chatter/invite_icon.png) no-repeat scroll left top;
    height: 33px;
}
.chatterListOverlay .externalInvite a {
    color: #015BA7;
    text-decoration:none;
}

.externalGroupAdminMailToLink {
    width: 240px;
    margin-bottom: 10px;
}

.externalGroupAdminMailToLink a {
    color: #015BA7;
    text-decoration:none;
}

.chatterListOverlay .externalInvite a:hover {
    text-decoration:underline;
}
.overlayList.groupList {
    margin-top: 0px;
}
.displayName a,
.memberDisplayName a {
    color: #015BA7;
    text-decoration: none;
    font-weight: bold;
}
.displayName a:hover {
    text-decoration: underline;
}
.groupList .memberCount {
    color: #7D7D84;
}
.infoGrey {
    background: transparent url(/img/feeds/info_grey.png) no-repeat;
    height: 16px;
    width: 16px;
    vertical-align: middle;
}

.overlayList.groupList .overlayListPhoto a {
    display: block;
    position: relative;
}

.overlayListPhoto .groupOwnerContainer img.groupOwnerIcon {
    background:#FFFFFF url(/img/chatter/owner_key_icon.png) no-repeat scroll 1px 1px;
    position: absolute;
    left: 20px;
    top: 20px;
    border-bottom: 1px solid #D4DADC;
    border-right: 1px solid #D4DADC;
    width: 12px;
    height: 12px;
}

.overlayListPhoto .groupOwnerContainer {
    position: relative;
}


/* --------------------------------------------------------------------------------- */
/* END Overlay Styles                                                                */
/* --------------------------------------------------------------------------------- */

/* sharing file dialog styles */
.sharedWithListOverlayPanel {
    border: 1px solid transparent;
    margin-bottom: 10px;
}

.sharedWithListOverlayPanel .sharedWithStatusBar,
.filesDetailPage .sharedWithStatusBar {
    margin-top: 25px;
    margin-bottom: 16px;
    padding-left: 10px;
    padding-top: 6px;
    padding-bottom: 6px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border: 1px solid #fceeb4;
    background-color: #ffffdc;
}

.sharedWithListOverlayPanel .notificationEmailPanel .sharedWithStatusBar {
    margin-top: 0;
    margin-bottom: 0;
}

.filesDetailPage .sharedWithStatusBar {
    margin-top: 0;
    margin-bottom: 5px;
}

.sharedWithListOverlayPanel .pageHelpIconPanel,
.chatterFilesTabPageHeader .pageHelpIconPanel,
.publishToLibContentOverlayPanel .pageHelpIconPanel {
    float: right;
}

.sharedWithListOverlayPanel .pageHelpIconPanel .helpIcon,
.chatterFilesTabPageHeader .pageHelpIconPanel .helpIcon,
.sharedWithListOverlayPanel .overlayListHeader .infoIcon,
.publishToLibContentOverlayPanel .pageHelpIconPanel .helpIcon {
    vertical-align: bottom;
}

.sharedWithListOverlayPanel .pageHelpIconPanel a,
.sharedWithListOverlayPanel .pageHelpIconPanel a:hover,
.chatterFilesTabPageHeader .pageHelpIconPanel a,
.chatterFilesTabPageHeader .pageHelpIconPanel a:hover,
.publishToLibContentOverlayPanel .pageHelpIconPanel a,
.publishToLibContentOverlayPanel .pageHelpIconPanel a:hover {
    text-decoration: none;
}

.sharedWithListOverlayPanel .pageHelpIconPanel a:hover span,
.chatterFilesTabPageHeader .pageHelpIconPanel a:hover span {
    text-decoration: underline;
}

.sharedWithListOverlayPanel .pageHelpIconPanel .helpLink,
.chatterFilesTabPageHeader .pageHelpIconPanel .helpLink {
   font-size: 0.9em;
    padding-right: 5px;
}

.sharedWithListOverlayPanel .overlayListHeader .permissionsLabel,
.sharedWithListOverlayPanel .overlayListHeader .viewerColumnLabel,
.sharedWithListOverlayPanel .overlayListHeader .collaboratorColumnLabel {
    padding-right: 5px;
}

.makePrivateMsgPanel .makePrivateMsgIcon,
.sharedWithNoGroupMembershipMessage img,
.sharedWithStatusBar .sharingStatusIcon img,
.sharedWithListOverlayPanel .tinyDownArrowIcon,
.sharedWithListOverlayPanel a:hover .tinyDownArrowIcon,
.sharedWithPermissionDropdown .tinyDownArrowIcon,
.sharedWithOptionPanel .sharedWithStatusBar .tinyDownArrowIcon,
.sharedWithOptionPanel .sharedWithStatusBar:hover .tinyDownArrowIcon {
    background: transparent url(/img/chatterfiles/chatterfiles16_sprite.png) no-repeat;
}

.sharedWithListOverlayPanel .sharedWithStatusBar .sharingStatusIcon,
.filesDetailPage .sharedWithStatusBar .sharingStatusIcon {
    float: left;
    position: relative;
}

.sharedWithListOverlayPanel .sharedWithStatusBar .sharingStatusIcon .lockItemIcon {
    background-position: 0  -308px;
}

.sharedWithListOverlayPanel .sharedWithStatusBar .thumbnailLabel,
.filesDetailPage .sharedWithStatusBar .thumbnailLabel {
    margin-left: 22px;
}

#contentPublisherSlideDown .sharedWithStatusBar .thumbnailLabel {
    margin-left: 8px;
    vertical-align: bottom;
}

#contentPublisherSlideDown .sharedWithStatusBar {
    background: transparent url(/img/chatter/tablesGradient.png) repeat-x scroll 0 0;
    margin-left: 3px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
}

#contentPublisherSlideDown .sharedWithStatusBar:hover {
    background-color: #E3F3FF;
    background-image: none;
}

#contentPublisherSlideDown .sharedWithStatusBarFirstRow {
    padding-bottom: 10px;
}

#contentPublisherSlideDown .shareOptionRadio {
    margin-top: 0;
    vertical-align: top;
}

#contentPublisherSlideDown .sharedWithStatusBarFirstRow .thumbnailLabel,
#contentPublisherSlideDown .sharedWithStatusBarSecondRow .thumbnailLabel {
    margin-left: 48px;
    margin-top:-18px;
}

#contentPublisherSlideDown .sharedWithStatusBar .infoIcon {
    vertical-align: text-bottom;
    margin-left: 4px;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayList {
    border-left: 1px solid #DBDBDB;
    border-right: 1px solid #DBDBDB;
}

.sharedWithListOverlayPanel .sharedWithMessage {
    margin: 8px 2px 0;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListHeader,
.versionListOverlayPanel .chatterListOverlay .overlayListHeader {
    background:#FFFFFF url(/img/alohaSkin/grid_headerbg.gif) repeat-x scroll 0 bottom;
    font-weight: bold;
    border-top: 1px solid #DBDBDB;
    border-left: 1px solid #DBDBDB;
    border-right: 1px solid #DBDBDB;
    margin-top: 8px;
    margin-bottom: -10px;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable,
.versionListOverlayPanel .chatterListOverlay .overlayListTable{
    table-layout: fixed;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable {
    border-collapse: collapse;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListHeader td,
.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable td,
.versionListOverlayPanel .chatterListOverlay .overlayListHeader td,
.versionListOverlayPanel .chatterListOverlay .overlayListTable td {
    padding: 3px;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListHeader .firstColumn {
    width: 477px;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListHeader .secondColumn {
    width: 145px;
    border-left: 1px solid #DBDBDB;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable .displayName,
.versionListOverlayPanel .chatterListOverlay .overlayListTable .displayName {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    height: 17px;
    width: 290px;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable .displayName {
    width: 418px;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable .overlayListPermission {
    width: 140px;
    white-space: nowrap;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable .permissionLabel {
    margin-top: 9px;
    float: left;
    white-space: nowrap;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListPhoto img
.versionListOverlayPanel .chatterListOverlay .overlayListPhoto img {
    margin-bottom: 2px;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable .shareWithCompanyRow {
    background-color: #e0e8eb;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListTable .shareWithCompanyPermissionCell {
    width: 150px;
}

.sharedWithListOverlayPanel .overlayListPhoto div,
.versionListOverlayPanel .overlayListPhoto div {
    position: relative;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayList,
.versionListOverlayPanel .chatterListOverlay .overlayList {
    height: 205px;
}

.sharedWithListOverlayPanel .sharedWithLinkBar {
    margin-top: 8px;
}

.sharedWithListOverlayPanel .whiteSpaceAboveShareList {
    height: 30px;
}

.sharedWithSummaryList img.groupPrivateIcon {
    background:#FFFFFF url(/img/chatter/private_group_icon.gif) no-repeat scroll 0 0;
    position: absolute;
    top: 19px;
    left: 20px;
    border-bottom: 1px solid #D4DADC;
    border-right: 1px solid #D4DADC;
    width: 11px;
    height: 12px;
}

/*share file link styles */
.sharedWithListOverlayPanel a {
    color: #015BA7;
    text-decoration : none;
}

.sharedWithListOverlayPanel a:hover {
    text-decoration : underline;
}

/* END share file link styles */

.sharedWithListOverlayPanel .sharedWithLinkBar .sharedWithMoreLabel {
    font-weight:bold;
    color: #222222;
}

.sharedWithListOverlayPanel .sharedWithLinkBar .sharedWithBoldLink {
    font-weight:bold;
}

.sharedWithListOverlayPanel .sharedWithLinkBar .makePrivateLinkPanel {
    float: right;
    width: 144px;
    text-align: left;
}

.sharedWithListOverlayPanel .entitySearchBoxWithViewCollaborator {
    width: 240px;
}

.makePrivateMsgPanel .makePrivateMsgForChatterFile {
    float: right;
    width: 95%;
    margin-bottom: 15px;
}

.makePrivateMsgPanel .makePrivateMsgIcon {
    background-position: 0 -308px;
    float: left;
    width: 16px;
    height: 16px;
}

.sharedWithListOverlayPanel .entitySearchBox {
    margin: 3px;
    width: 477px;
    height: 20px;
    font-family: 'Arial', 'Helvetica', sans-serif;
    font-size: 100%;
}

.sharedWithListOverlayPanel .notificationEmailPanel {
    width: 481px;
    margin: 35px 0 5px;
}

.sharedWithListOverlayPanel .notificationEmailPanel .sendEmailOption {
    float: left;
    margin-top: 0;
    margin-right: 5px;
}

.sharedWithListOverlayPanel .notificationEmailPanel .optionalMsg {
    width: 100%;
    height: 70px;
    padding: 3px;
    margin-top: 5px;
}

.sharedWithListOverlayPanel .notificationEmailPanel .optionalMsgGhostText {
    color: #9F9F9F;
}

.sharedWithListOverlayPanel .chatterListOverlay .shareWithPeopleListHeader {
    width: 100%;
}

.sharedWithListOverlayPanel .entitySearchBox.ghostText {
    color: #9F9F9F;
}

.sharedWithListOverlayPanel .entitySearchBoxWithViewCollaborator {
    width: 240px;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayListHeader .thirdColumn {
    width: 143px;
    border-left: 1px solid #DBDBDB;
}

.sharedWithListOverlayPanel .chatterListOverlay .overlayList .overlayListWrapper {
    margin-bottom: 3px;
}

/* This should not be wrapped in sharedWithListOverlayPanel */
.sharedWithListWizard .chatterListOverlay .overlayList {
    height: 100%;
    overflow: hidden;
}

.sharedWithStatusBar .sharingStatusIcon .orgItemIcon {
    background-position: 0 -92px;
}

.sharedWithStatusBar .sharingStatusIcon .warningIcon {
    background-position: 0 -200px;
}

.sharedWithStatusBar .sharingStatusIcon .sharedItemIcon {
    background-position: 0  -239px;
}

.sharedWithStatusBar .sharingStatusIcon img {
    height: 16px;
    width: 16px;
}

#chatterFileSharedWithListDialog {
    position: absolute;
    word-wrap: break-word; /*W-928180 */
}

#chatterFileSharedWithListDialogTitle,
#chatterFilePublicLinkDialogTitle
 {
    display:block;
    width: 460px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

#shareWithEntityForm .overlayListTable {
    table-layout: fixed;
    width: 100%;
}

#shareWithEntityForm .chatterListOverlay {
    margin-top: 25px;
}

#shareWithEntityForm .overlayListName {
    color:#222;
    font-weight:bold;
    text-decoration:none;
}

#shareWithEntityForm .overlayListOwner {
    width:230px;
    vertical-align: middle;
    border-left: 3px solid #FFFFFF;
}

#shareWithEntityForm .overlayOwnerSpan {
    font-size: 0.92em;
    background: #ffffcc url(/img/msg_icons/info16.gif) 2px 2px no-repeat;
    border:1px solid #ccc;
    padding-top:3px;
    padding-right:3px;
    padding-bottom:4px;
    padding-left:20px;
    margin-top:2px;
    margin-right:2px;
    margin-bottom:2px;
    margin-left:11px;
    position: relative;
    white-space:nowrap;
}


#shareWithEntityForm .overlayListViewer {
    width:106px;
    border-left: 3px solid #FFFFFF;
}

#shareWithEntityForm .overlayListCollaborator {
    width:119px;
    border-left: 3px solid #FFFFFF;
}

#shareWithEntityForm .overlayListName .titleSpan {
    font-weight:normal;
}

#shareWithEntityForm .overlayListLink {
    width: 35px;
}

#shareWithEntityForm .chatterListOverlay .overlayListTable td {
    border-bottom: none;
    padding-top: 5px;
}
#shareWithEntityForm .chatterListOverlay .overlayListTable td.notFirstRow {
    border-top: 1px solid #EDEDED;
}

#sharedWithInputBox_autoCompleteBoxId .ugAC_userRole {
    color: #4A4A56;
    font-size: 0.9em;
}

.sharedWithListWizard .chatterListOverlay .overlayScrollList {
    height: 125px;
    overflow-x: hidden;
    overflow-y: auto;
}

.sharedWithListWizard .chatterListOverlay .sharingOptionRadio {
    margin: 9px 45px;
}

.sharedWithListWizard .notificationEmailPanel .sendEmailOptionLabel,
.sharedWithListWizard .notificationEmailPanel .wallPostLabel {
    padding-left: 0;
}

.sharedWithListWizard .maxSharedWithPeopleCntMsg {
    color: #EA9800;
    padding: 5px 8px;

}

#shareWithEntityForm .chatterListOverlay .overlayListPhoto img {
    margin-bottom: 0px;
}

#selectedPeopleToShareList {
    border-bottom: 1px solid #EDEDED;
}

#selectedPeopleToShareList.noBottomBorder {
    border-bottom: 0;
}

#selectedPeopleToShareList .shareWithCompanyShortName {
    color: #015BA7;
}

.sharedWithNoGroupMembershipMessage {
    margin-bottom: 15px;
}
.sharedWithNoGroupMembershipMessage a {
    text-decoration: underline;
    color: #015BA7;
}

.sharedWithNoGroupMembershipMessage img {
    background-position: 0 -200px;
    width: 16px;
    height: 16px;
    margin-right: 10px;
    vertical-align: bottom;
}

.sharedWithListOverlayPanel a:hover .permissionLabel {
    text-decoration:underline;
    cursor: hand;
}

.sharedWithListOverlayPanel .tinyDownArrowIcon,
.sharedWithPermissionDropdown .tinyDownArrowIcon,
.chatterFileDetailActionListPanel .tinyDownArrowIcon,
.sharedWithOptionPanel .sharedWithStatusBar .tinyDownArrowIcon,
.sharedWithOptionPanel .sharedWithStatusBar:hover .tinyDownArrowIcon {
    padding-right: 15px;
    height: 10px;
}

.sharedWithListOverlayPanel .tinyDownArrowIcon,
.sharedWithPermissionDropdown .tinyDownArrowIcon,
.chatterFileDetailActionListPanel .tinyDownArrowIcon,
.sharedWithOptionPanel .sharedWithStatusBar:hover .tinyDownArrowIcon {
    background-position: 0px -186px;
}

.sharedWithOptionPanel .sharedWithStatusBar .tinyDownArrowIcon {
    background-position: 0px -168px;
}

.chatterFileDetailActionListPanel .tinyDownArrowIcon {
    margin-bottom: 5px;
}

.FileDetailPage .contentActionMenuItem {
    padding-left: 0;
}
.FileDetailPage .dropdownPanel {
    border: 1px solid #B6B6B6;
    -moz-border-radius: 5px;
    radius: 5px;
    -moz-box-shadow: 0 2px 5px #A0A6AB;
}

.FileDetailPage .dropdownPanel .sharedWithOptionLi a{
    color: #222;
    display: block;
    padding-bottom: 5px;
    padding-top: 5px;
    text-decoration: none;
}

.FileDetailPage .dropdownPanel .sharedWithOptionLi a:hover{
    color: #015BA7;
}

.sharedWithListOverlayPanel .tinyDownArrowIcon {
    margin-top: 9px;
}

.sharedWithPermissionDropdown .tinyDownArrowIcon {
    height: 11px;
    margin-left: -3px;
}

.sharedWithOptionPanel .sharedWithStatusBar .tinyDownArrowIcon {
    float: right;
}

.sharedWithListOverlayPanel .permissionActionLink {
    white-space: nowrap;
    float: left;
}

.sharedWithListOverlayPanel a:hover .tinyDownArrowIcon {
    background-position: 0px -186px;
}

.permissionActionLinkPanel {
    padding-top : 8px;
}

.permissionActionLinkPanel a {
    color: #222;
    text-decoration: none;
    width: 81%;
}

.permissionLabelPanel .permissionLabel {
    padding-left : 10px;
    color: #015ba7;
}

/* sharedWithPermissionDropdown */
.sharedWithPermissionDropdown {
    border : 1px solid #d4dadc;
    position : absolute;
    z-index : 60005;
    background-color : #ffffff;
    border-radius: 5px;
    box-shadow: 0 2px 5px #ACACAC;
    -moz-border-radius: 5px;
    -moz-box-shadow: 0 2px 5px #ACACAC;
    -webkit-border-radius: 5px;
    -webkit-box-shadow: 0 2px 5px #ACACAC;
    padding-top : 9px;
    padding-bottom: 9px;
    padding-right: 4px;
    padding-left: 4px;
}

.sharedWithPermissionDropdown .permissionActionLink,
.sharedWithPermissionDropdown .permissionActionLink:hover {
    white-space: nowrap;
    float: left;
    font: normal #222;
    text-decoration: none;
    -moz-border-radius: 7px;
    -webkit-border-radius: 7px;
    padding: 4px 10px;
    background-color: #ffffff;
    cursor: pointer;
}


.sharedWithPermissionDropdown .permissionLabelPanel a {
    text-decoration: none;
}


.sharedWithPermissionDropdown .permissionActionLink:hover {
    color: #015ba7;
    text-decoration: underline;
    background-color: #cfeef8;
}

.makePrivateMsgPanel .makePrivateMsgForContentFile,
.makePrivateMsgPanel .stopSharingMsg,
.changePermissionMsgPanel .changePermissionMsg {
    white-space: normal;
    word-wrap: break-word;
    margin-bottom: 15px;
}

.makePrivateMsgPanel .stopSharingMsg .stopSharingWithCompany {
    font-weight: bold;
}

.makePrivateMsgPanel .stopSharingMsg .stopSharingWithCompanyDescription {
    margin: 20px;
}

.confirmationMsgPanel img {
    height: 32px;
    width: 32px;
    background: transparent url(/img/chatterfiles/chatterfiles32_sprite.png) no-repeat;
}

.confirmationMsgPanel .icon {
    background-position: 0 0;
    float: left;
}

.confirmationMsgPanel .confirmationMsg {
    padding-top: 4px;
    padding-bottom: 15px;
    width: 360px;
    float: right;
}

.chatterListOverlay .overlayListTable .permissionLink {
    float: right;
}

.chatterListOverlay .overlayListTable .permissionLink a .deleteIconClass {
    margin-top: 9px;
    margin-right: 5px;
}

.overlayList a .deleteIconClass {
    background: transparent url(/img/feeds/follow_sprite.png) no-repeat scroll 0 -54px;
    border:medium none;
    cursor:pointer;
    margin-top:7px;
    height:15px;
    width:15px;
}

.firstColumn > div.mouseOverInfoOuter,
.secondColumn > div.mouseOverInfoOuter,
.thirdColumn > div.mouseOverInfoOuter {
    position: relative;
}

.chatterListOverlay .overlayListTable .shortSharedWithName,
.chatterListOverlay .overlayListTable .longSharedWithName {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
    height: 17px;
    width: 415px;
}

.chatterListOverlay .overlayListTable .shortSharedWithName {
    width: 275px;
    display: inline-block;
}

.chatterListOverlay .overlayListTable .longSharedWithName {
    width: 380px;
    display: inline-block;
}

.chatterListOverlay .overlayListTable .displayNameWidthWithViewCollaborator {
    width: 279px;
}

.chatterListOverlay .overlayListTable .displayNameWidthWithCompanyShare {
    width: 200px;
}

/* END sharing file dialog styles */

/* --------------------------------------------------------------------------------- */
/* Dropdown panel styles                                                             */
/* --------------------------------------------------------------------------------- */
.dropdownPanel {
    border : 1px solid #d4dadc;
    position : absolute;
    z-index : 102;
    background-color : #ffffff;
    border-radius: 0 0 5px 5px;
    box-shadow: 0 2px 5px #ACACAC;
    -moz-border-radius: 0 0 5px 5px;
    -moz-box-shadow: 0 2px 5px #ACACAC;
    -webkit-border-radius: 0 0 5px 5px;
    -webkit-box-shadow: 0 2px 5px #ACACAC;
    z-index: 60005;
}

.dropdownPanel .sharedWithStatusBar a {
    padding-left: 41px;
}

.dropdownPanel .sharedWithStatusBar  a.lockItemIcon{
    background-position: 20px -304px; /*0px 308px*/
}

.dropdownPanel .sharedWithStatusBar a.peopleItemIcon {
    background-position: 20px 100px; /*0px 362px*/
}

.dropdownPanel .sharedWithStatusBar a.groupItemIcon {
    background-position: 20px 100px; /*0px 236px*/
}

.dropdownPanel .sharedWithStatusBar a.linkItemIcon {
    background-position: 20px 100px; /*0px 236px*/
}

.dropdownPanel .sharedWithStatusBar.checked {
    background: transparent url(/img/chatterfiles/chatterfiles16_sprite.png) no-repeat 2px -378px; /*0px 380px*/
}

.dropdownPanel .sharedWithStatusBar:hover {
    background-color: #D0EEF8;
}
/* --------------------------------------------------------------------------------- */
/* End Dropdown panel styles                                                             */
/* --------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------- */
/* File upload overlay styles                                                        */
/* --------------------------------------------------------------------------------- */
.sharedWithOptionPanel .sharedWithStatusBar a,
.dropdownPanel .sharedWithStatusBar a {
    background: transparent url(/img/chatterfiles/chatterfiles16_sprite.png) no-repeat;
    padding-top: 5px;
    padding-bottom: 5px;
    display: block;
    color: #222222;
    text-decoration: none;
}

.sharedWithOptionPanel ul,
.dropdownPanel ul {
    list-style: none;
}

.sharedWithOptionPanel ul, .sharedWithOptionPanel li,
.dropdownPanel ul, .dropdownPanel li {
    padding: 0;
    margin: 0;
}

.dropdownPanel .actionBarShareWithUl,
.dropdownPanel .actionBarShareWithUlWithTopBorder {
    margin-left: 5px;
    margin-right: 5px;
}

.dropdownPanel .actionBarShareWithUlWithTopBorder {
    border-top: 1px solid #D4DADC;
}

.sharedWithOptionPanel .sharedWithStatusBar a {
    padding-left: 26px;
}

#contentPublisherSlideDown div.sharedWithOptionPanel a {
    text-decoration: none;
    color: #222222;
}

/**
 * Styles used by the ChatterFileUploadDialog
 *
 * These can be used from any page that has a feed, a file list, or from the file-tab directly.
 * Hence they are included in chatterCore.css
 */
#chatterFilesTabPageUploadDialog.show {
    opacity: 1;
    -moz-opacity: 1;
    filter: alpha(opacity = 100);
    position: fixed;
}

#chatterFilesTabPageUploadDialog.invisible {
    opacity: 0;
    -moz-opacity: 0;
    filter: alpha(opacity = 0);
    top: -1000px;
    position: absolute;
}

#chatterFilesTabPageUploadDialog table.postInput {
    margin: 0 27px;
}

#chatterFileNewLabel_upload {
    margin: 0 19px 3px;
}

.chatterFilesTabPageUploadPanel .uploadFileMsgPanel {
    margin-top: 10px;
    margin-bottom: 15px;
    margin- right: 0;
    margin- left: 50px;
}

.chatterFilesTabPageUploadPanel .uploadFileMsgIcon {
    background-position: 0 -308px;
    float: left;
    width: 16px;
    height: 16px;
}

.chatterFilesTabPageUploadPanel .uploadFileMsg {
    margin- left: 18px;
    width: 90%;
}

.chatterFilesTabPageUploadPanel .uploadFileMsgPanel {
    margin-top: 10px;
    margin-bottom: 15px;
    margin- right: 0;
    margin- left: 50px;
}

.chatterFilesTabPageUploadPanel .uploadFileMsgIcon {
    background-position: 0 -308px;
    float: left;
    width: 16px;
    height: 16px;
}

.chatterFilesTabPageUploadPanel .uploadFileMsgIcon,
.chatterFilesTabPageUploadPanel .uploadNewVersionMsg {
    background: transparent url(/img/chatterfiles/chatterfiles16_sprite.png) no-repeat;
}

.chatterFilesTabPageUploadPanel .uploadNewVersionMsg {
    background-position: 0 -200px;
    padding- left: 23px;
    width: 90%;
    height: 22px;
}

.chatterFilesTabPageUploadPanel .uploadButtonBar {
    text-align: center;
}

.sharedWithOptionPanel .sharedWithStatusBar {
    margin: 6px 0;
    border: 1px solid #c7c7c7;
    background-color: #fafafa;
}

.sharedWithOptionPanel .sharedWithStatusBar .sharedWithLabel {
    padding-left: 5px;
}

.sharedWithOptionPanel .sharedWithStatusBar a.lockItemIcon {
    background-position: 5px -304px; /*0px 308px*/
}

.sharedWithOptionPanel .sharedWithStatusBar a.peopleItemIcon {
    background-position: 5px 100px; /*0px 362px*/
}

.sharedWithOptionPanel .sharedWithStatusBar a.groupItemIcon {
    background-position: 5px 100px; /*0px 236px*/
}

.sharedWithOptionPanel .sharedWithStatusBar a.linkItemIcon {
    background-position: 5px 100px; /*0px 236px*/
}

.sharedWithOptionPanel .sharedWithStatusBar a.companyItemIcon {
    background-position: 5px 100px; /*0px 236px*/
}

/* --------------------------------------------------------------------------------- */
/* END File upload overlay styles                                                    */
/* --------------------------------------------------------------------------------- */


/* --------------------------------------------------------------------------------------- */
/* File Public link  overlay styles                                                        */
/* --------------------------------------------------------------------------------------- */
.sharedWithLinkBar .shareFileWithItemIcon {
    background: transparent url(/img/chatterfiles/chatterfiles16_sprite.png) no-repeat;
    background-position: 0 -56px;
    height: 16px;
    width: 16px;
    maring-bottom: -4px;
    vertical-align: top;
}

#sideBarShareWithOption {
    padding-top: 5px;
    padding-bottom: 5px;
}
#sideBarShareWithOption .contentActionMenuItem {
    margin-left: 5px;
    margin-right: 5px;
    height: 23px;
}

.publicLinkValueDiv .publicLinkInfoMessage {
    position: relative;
    margin-left: 0;
    margin-right: 0;
    margin-bottom: 15px;
}

.publicLinkValueDiv .messageTable td {
    vertical-align: top;
}

.publicLinkValueDiv .messageTable .messageText {
    font-size: 0.9em;
}

.publicLinkValueDiv .publicLinkValueInput {
    background: none repeat scroll 0 0 #FFFFFF;
    width: 485px;
    margin-top:10px;
    margin-bottom:10px;
    border: #959595 1px solid;
    padding-top: 4px;
    padding-right: 4px;
    padding-left: 3px;
    padding-bottom: 4px;
    -moz-box-shadow: 0 1px 1px #D9D9D9 inset;
}

.publicLinkValueDiv .publicLinkValueButton {
    margin-bottom:10px;
}

.filePublicLinkButton {
    margin-top: 16px;
    margin-bottom: 10px;
}

.filePublicLinkButton .btn {
    min-width: 48px;
    width: 48px;
}

.publicLinkSettingDiv .linkSettingHeader .publicLinkSetupImageCollapse,
.publicLinkSettingDiv .linkSettingHeader .publicLinkSetupImageExpand{
    width: 16px;
    height: 16px;
    padding: 0;
    cursor: pointer;
}

.publicLinkSettingDiv .linkSettingHeader .publicLinkSetupImageCollapse {
    background: url("/img/support/caseinteraction/pluses_sprite.png") 0 0;
}

.publicLinkSettingDiv .linkSettingHeader .publicLinkSetupImageCollapse:hover {
    background: url("/img/support/caseinteraction/pluses_sprite.png") 0 -16px;
}

.publicLinkSettingDiv .linkSettingHeader .publicLinkSetupImageExpand {
    background: url("/img/support/caseinteraction/pluses_sprite.png") 0 -32px;
}

.publicLinkSettingDiv .linkSettingHeader .publicLinkSetupImageExpand:hover {
    background: url("/img/support/caseinteraction/pluses_sprite.png") 0 -48px;
}

.publicLinkSettingDiv .linkSettingHeader .linkSettingHeaderSpan {
    font-size: 1.1em;
    position: relative;
    top: -1px;
}


.publicLinkSettingDiv .linkSettingDetail .liItem {
    margin-top: 2px;
    margin-right: 0;
    margin-bottom: 2px;
    margin-left: 10px;
    line-height: 18px;
}

.publicLinkSettingDiv .linkSettingDetail .liItem .liLabel{
    position: relative;
    top: -1px;
    padding-left: 2px;
}

.publicLinkSettingDiv .linkSettingHeader {
    margin-bottom: 5px;
}

/*******************************************************/
/* preview style                                       */
/*******************************************************/
.docViewerPanel {
    z-index: 100;
    width: 100%;
    height: 100%;
    display: block;
    top: 0;
    left: 0;
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0.5);
    overflow-x: auto;
    overflow-y: auto;
    position: fixed;
}

.bodyForDocViewerPanel {
    overflow-x: hidden;
    overflow-y: hidden;

}

.overlayDialog.docViewerOverlay {
    position: absolute;
}

/* --------------------------------------------------------------------------------------- */
/* End of File Public link  overlay styles                                                 */
/* --------------------------------------------------------------------------------------- */


/* custom feed item: ApprovalFeedItem */

.feedPostEntityDetails {
    padding-top: 6px;
    padding-bottom: 6px;
}

.feedPostTemplateDetails {
    padding-top: 2px;
    padding-bottom: 0px;
}

/* style class for label common to template view and record view */
.approvalPostTable .approvalDetailsLabel {
    font-size: 91%;
    font-weight: bold;
    color: #4a4a56;
    padding-left: 12px;
}

.approvalPostTable .labelCell {
    text-align: right;
    vertical-align: top;
}

.approvalPostTable .labelCellTpl {
    text-align: right;
    vertical-align: top;
    width: 120px;
}

/* style class for detail property value, common to template view and record view */
.approvalPostTable .approvalDetails {
    color: #222222;
    padding-left: 0px;
}

.approvalPostTable .valueCell {
    padding-left: 13px;
    padding-right: 12px;
}

.feedPostEntityDetails .Pending {
    font-weight: bold;
    color: #bfa704;
}

.feedPostEntityDetails .Approved {
    font-weight: bold;
    color: #08a705;
}

.feedPostEntityDetails .Rejected {
    color: #da0000;
    font-weight: bold;
}

.feedPostEntityDetails .Removed, .Reassigned {
    color: #8a3bcd;
    font-weight: bold;
}

/* style classes for action bar that replaces buttons on a non-actionable item */
.actionBar {
    margin-top: 4px;
    margin-bottom: 5px;
}

.actionBar .approved {
    border: 1px solid #9bebb3;
    background-color: #edfff1;
    height: 23px;
    color: #222;
    line-height: 23px;
    display:inline-block;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
}

.actionBar .approvedIcon {
    padding: 12px 0 10px 22px;
    margin: 0;
    color: #000;
    background: url(/img/msg_icons/confirm16.gif) left center no-repeat;
}

.actionBar .rejected {
    border: 1px solid #f2a199;
    background-color: #fdedea;
    height: 23px;
    color: #222;
    line-height: 23px;
    display:inline-block;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
}

.actionBar .rejectedIcon {
    padding: 12px 0 10px 22px;
    margin:0;
    color: #000;
    background:url(/img/feeds/rejected16.png) left center no-repeat;
}

.actionBar .info {
    border: 1px solid #bee6ff;
    background-color: #f5fcff;
    height: 23px;
    color: #222;
    line-height: 23px;
    display:inline-block;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
}

.actionBar .infoIcon {
    padding: 12px 0 10px 22px;
    margin:0;
    color: #000;
    background:url(/img/msg_icons/info16.gif) left center no-repeat;
}

.actionBar .infoIcon:hover {
    background-position: 0;
}

.overlayPanel {
    width: 450px;
    height: 120px;
    background-position: center center;
}

.overlayPanel .msgIcon{
    float:left;
}

.overlayPanel .messageText{
    margin-left:30px;
}

.spinner {
    border: none;
    background-color: #FFF;
    background-image: url(/img/dataCategories/spinner.gif);
	background-position: 0px 0px;width:16px;
	height:16px;
    background-position:center center;
    background-repeat:no-repeat;
    width: 450px;
    height: 120px;
}

.nextApproverOverlay .nextApproverPrompt {
    margin-top: 5px;
    text-align: center;
}

.nextApproverOverlay .nextApproverWrapper {
    position:relative;
}

.nextApproverOverlay .requiredInput {
    margin-top: 10px;
    margin-bottom: 10px;
}

.nextApproverOverlay .requiredInput * .errorMsg{
    white-space:normal;
    position:relative;
}

.nextApproverOverlay .lookupInput {
    margin-left: 10px;
    position: relative;
    top: -1px;
}

.nextApproverOverlay .lookupInput select {
    margin-left: 4px
}

.nextApproverOverlay .lookupInput input {
    width: 179px;
    height: 18px;
}

.nextApproverOverlay .lookupInput a {
    position: relative;
    top: -1px;
    margin-left: 3px;
}

.nextApproverOverlay .errorMsg {
    text-indent: 8px;
    margin-top: 5px;
    text-align: center;
}

.nextApproverOverlay .errorMsg .strong {
    font-weight: bold;
}

.feedPostComment {
    width: 430px;
    height: 80px;
}

/* END:custom feed item: ApprovalFeedItem */

/* Custom feed item: Case events */

.caseEventCustomerIndicator {
    color: #f07e05;
}

.caseEventBody,
.caseCommentEventBody {
    display: block;
    margin: 6px 0 6px 3px;
}

.caseEventRow,
.caseCommentEventRow {
    display: block;
    margin-left: 28px;
}

.caseChangeStatusEventBody {
    display: block;
    margin-top: 3px;
    margin-left: 0px;
}

.caseEventLabel {
    color: #7d7d84;
    padding-right: 3px;
}

.caseEventIcon,
.caseCommentEventIcon {
    float: left;
}

.caseEventSeparator {
    padding-left: 5px;
}
.caseEventWideSeparator {
    padding-left: 12px;
}

.caseEventAttachments {
    display: block;
    margin-top: 6px;
}

.caseEventAttchmentIcon {
    float: left;
}

.caseEventAttachment a {
    font-weight: bold;
    margin-bottom: 6px;
    display: block;
    margin-left: 22px;
}

.caseEventAction,
.caseCommentEventAction  {
    font-size: 0.92em;
    font-weight: normal;
}

.caseCommentEventOriginalPostByLabel {
    color: #4A4A56;
}

.caseCommentEventOriginalPostBy {
    font-size: 0.92em;
}

.caseEventUnavailable {
    color: #7b797b;
    font-style: italic;
    font-weight: normal;
    font-size: 0.9em;
}

.caseCommentPostEventIcon img {
    height: 16px;
    width: 22px;
    background: transparent url(/img/support/caseinteraction/caseIcon_sprite.png) 0 -237px no-repeat;
}

.caseCommentRemoveEventIcon img {
    height: 16px;
    width: 22px;
    background: transparent url(/img/support/caseinteraction/caseIcon_sprite.png) 0 -301px no-repeat;
}

.emailMessageInboundEventIcon img {
    height: 16px;
    width: 22px;
    background: transparent url(/img/support/caseinteraction/caseIcon_sprite.png) 0 -252px no-repeat;
}

.emailMessageOutboundEventIcon img {
    height: 16px;
    width: 22px;
    background: transparent url(/img/support/caseinteraction/caseIcon_sprite.png) 0 -285px no-repeat;
}

.caseAttachArticleEventIcon img {
    height: 16px;
    width: 16px;
    background: transparent url(/img/knowledge/knowledge16.png) 0 0 no-repeat;

}

.caseEventActionRow{
    padding: 8px 0 2px 0;
}

.caseOriginalCommentContents {
    color: #7d7d84;
}

/* END:custom feed item: Case events */

/* To Do List */

.todoList {
    background:url("/img/chatter/wtdNowGradientbg.png") repeat-x 0 0 scroll;
    background-color:#ffe5a7;
}

.todoList .recElementName {
    font-weight: bold;
}

.todoList a {
    color: #015BA7;
    text-decoration: none;
}

.todoList  .recImage {
    float:	right;
    height:	40px;
    width:	40px;
    border:	0;
}

.todoList p {
    margin: 0 ;
    padding-top: 4px;

}

.todoList .dismiss{
    margin-top:  	8px ;
}

.todoElement .recImage, .recommend .recBox .todoElement .recImage {
    float:	right;
    height:	40px;
    width:	40px;
    border:	0;
    margin-left: 6px;
}

.recommend .recBox .todoElement  {
	padding:  1px 0 2px !important;
}

#todoItem {
	padding: 16px 14px 10px;
}

#todoItem.success {
    background: none repeat scroll 0 0 #edfff1;
     border:    2px solid #9bebb3;
}

.todoElement  .dismiss {
    font-size: 0.9em;
    margin-top: 14px
}

#todoItem.success  img {
    background: url("/img/msg_icons/confirm24.png") no-repeat 0 0;
    width: 25px;
}

.todoList img.user {
    background: url("/img/chatter/wtdNowIcon_sprite.png") no-repeat 0 -52px;
}

.todoList img.group {
    background: url("/img/chatter/wtdNowIcon_sprite.png") no-repeat 0 -2px;
}

.todoList img.video {
    background: url("/img/chatter/wtdNowIcon_sprite.png") no-repeat 0 -102px;
}

.todoList img.desktop {
    background: url("/img/chatter/wtdNowIcon_sprite.png") no-repeat 0 -142px;
}

.todoList img.mobile {
    background: url("/img/chatter/wtdNowIcon_sprite.png") no-repeat 0 -192px;
}

.todoList img.photo {
    background: url("/img/chatter/wtdNowIcon_sprite.png") no-repeat 0 -242px;
}

.todoList img.shortVideo {
    background: url("/img/chatter/wtdNowIcon_sprite.png") no-repeat 0 -102px;
}

/* END To Do List */



/* BEGIN CheckedMenuElement */
.checkedMenu {
    color: #222222;
    display: inline;
    cursor: pointer;
    line-height: 11px;
    position: relative; /* required for popup positioning */
}

.checkedMenu a.checkedMenuButton {
    background: url(/img/mink_arrow.png) no-repeat right -10px;
    padding-top: 2px;
    padding-right: 16px;
    padding-bottom: 3px;
    padding-left: 3px;
    display: inline;
    color: #015BA7;
    font-size: 0.9em;
    white-space: nowrap;
}

.checkedMenu a.checkedMenuButton:hover {
    background-position: right 6px;
    text-decoration: underline;
}

.checkedMenu .checkedMenuMenu {
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-box-shadow: 0 2px 5px #ACACAC;
    -webkit-box-shadow: 0 2px 5px #ACACAC;
    box-shadow: 0 2px 5px #ACACAC;
    background-color: #FFF;
    border: 1px solid;
    border-color: #D4DADC;
    display: none;
    margin-top: 2px;
    padding: 7px 5px 7px;
    position: absolute;
    left: auto;
    right: 0;
    text-align: left;
    z-index: 50;
    white-space: nowrap;
}

.checkedMenu .checkedMenuOptionIcon {
    float: left;
    height: 12px;
    margin-top: 6px;
    width: 12px;
}

.checkedMenu .checkedMenuChecked {
    background: #fff url(/img/mink_arrow.png) no-repeat;
    background-position: 0 -28px;
}

.checkedMenu a.checkedMenuMenuLink:hover {
    -moz-border-radius: 11px;
    -webkit-border-radius: 11px;
    border-radius: 11px;
}

.checkedMenu .checkedMenuMenu a,
.checkedMenu .checkedMenuMenu input.theOption {
    color: #015BA7;
    display: block;
    font-size: 0.9em;
    margin-left: 12px;
    padding: 5px 6px;
    text-decoration: none;
    white-space: nowrap;
    word-wrap:normal;
}

.checkedMenu .checkedMenuMenu a:hover {
    background-color: #E3F3FF;
}

.checkedMenu span.checkedMenuLabel {
    cursor: default;
    font-size: 0.9em;
    white-space: nowrap;
}
/* end CheckedMenu element */



/*CSN Publisher*/
.publishercontainer {
    background:transparent url(/img/alohaSkin/feeds/cloud.png) no-repeat scroll right top;
    border: 0;
    line-height: normal;
    padding-top: 10px;
    padding-left: 0;
    max-width: 640px;
    overflow: visible;
    position:relative;
    border-bottom:1px solid #e6e6e6;
    padding-bottom:10px;
    margin-bottom:15px;
    min-height:75px;
}
.publishercontainer .clear {
    clear:both;
}
.publisherwithphoto div.publisherrightcontainer {
    margin-left:72px;
}
.publishercontainer .publisherrightcontainer {
    padding: 0 0 7px 0;
    padding-right:20px;
}
.publishercontainer .publisherlabel {
    color: #4a4a56;
    font-size:0.9em;
    font-weight:bold;
    margin-top: 2px;
}
.publishercontainer .publishercontrols .publishertextarea {
    margin-bottom: 2px;
    height:1.34em;
}
.publishercontainer .publishercontrols span.publisherlabel {
    float: left;
}
.publishercontainer .publishercontrols a.publisherattach,
a.cxcontentcommentaction {
    color:#015ba7;
    padding: 1px;
    font-size: 0.9em;
    font-weight: bold;
    text-decoration: none;
    float: left;
}

.publishercontainer .publishercontrols a.publisherattach {
    margin-left: 15px;
}
    
    
.publishercontainer .publishercontrols a.publisherattach:hover,
a.cxcontentcommentaction:hover {
    text-decoration: none;
}
.publishercontainer .publishercontrols a.publisherattach:hover span,
a.cxcontentcommentaction:hover span {
    text-decoration: underline;
}
.publishercontainer a.publisherattach span,
a.cxcontentcommentaction span
 {
    margin-left: 5px;
    line-height: 16px;
}
.publishercontainer a.publisherattach img,
.linkPostLinkContainer a.linkPostLink img,
a.cxcontentcommentaction img {
    height: 16px;
    width: 16px;
    background:transparent url(/img/feeds/publisher_icon16.png) no-repeat scroll left top;
    float: left;
}
.publishercontainer a.publisherattach img.publisherattachfile,
a.cxcontentcommentaction img
 {
    background-position:0 -16px;
}
.publishercontainer a.publisherattach img.publisherattachlink {
    background-position:0 0;
}
.publishercontainer .publishersharebutton {
    float: right;
    margin: 0 -10px 6px 0;
}

.externalGroupWarning {
    float: right;
    color: #F07E05;
    background-color: #F5FCFF;
    border-color: #BEE6FF;
    border-style: solid;
    border-width: 1px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    padding: 2px 8px;
    margin-right: 8px;
    margin-top: 2px;
}

.publishertextarea a.isMention:hover,
.cxnewcommenttext a.isMention:hover {
    text-decoration:none;
}

.publishertextarea a.isMention,
.cxnewcommenttext a.isMention {
    cursor:default;
    color: #015BA7;
    white-space: nowrap;
    text-decoration:none;
    font-weight:normal;
}

.publishertextarea a.isMentionDisabled,
.cxnewcommenttext a.isMentionDisabled {
    color: #7d7d84;
}

.publisherAC_box {
    box-shadow: 0 1px 4px 1px #96969C;
    -moz-box-shadow: 0 1px 4px 1px #96969C;
    -webkit-box-shadow: 0 1px 4px 1px #96969C;
    margin-top:1px;
    border-color: #a7b0b4;
    border-style: solid;
    border-width: 1px;
}

.publisherAC_box.publisherAC_boxForOverlay {    
    position: fixed;
}

.publisherAC_box .publisherAC_help {
    color: #cf700b;
    font-weight:normal;
    font-size:100%;
    padding-left:6px;
    padding-top:3px;
    padding-bottom:3px;
}

.publisherAC_box .publisherAC_userRole {
    color: #7d7d84;
    font-style:normal;
    padding-left:8px;
    display:inline-block;
}

.publisherAC_box .publisherAC_noMatch {
    color: #999999;
    font-style:italic;
    margin-left:3px;
    padding:2px 6px;
}

.publisherAC_box .autoCompleteRow {
    padding-top: 0.1em;
    padding-left: 10px;
}

.publisherAC_box .publisherAC_row_hover {
    color:#015ba7;
}

.publisherAC_box .publisherAC_list {
    list-style-image:none;
    list-style-position:outside;
    list-style-type:none;
    padding:0;
    margin:0;
}

.publisherAC_box .publisherAC_list li {
    margin:0;
}

.publisherAC_box .publisherAC_list li .name {
    display:inline-block; /*display:inline-block helps with RTR languages*/
}

.publisherAC_box .publisherAC_title {
    color: #222;
    height:1.8em;
    line-height: 1.8em;
    background-color:#f2f5f7;
    font-size: 100%;
    padding-left:10px;
    padding-top:0.2em;
    padding-bottom:0.1em;
}

.publisherAC_box .publisherAC_title_selected {
    height:1.8em;
    line-height: 1.8em;
    font-size: 100%;
    white-space: nowrap;
    padding-left:10px;
    margin: 0;
    cursor: pointer;
    background-color : #c6e1ff;
    border: 1px solid #99ccff;
    margin-top:0.3em;
    padding-top:0.2em;
}

.publisherAC_box .publisherAC_clickableTitle {
    height:1.8em;
    line-height: 1.8em;
    font-size: 100%;
    white-space: nowrap;
    padding-left:10px;
    margin: 0 0;
    cursor: pointer;
    background-color:#f2f5f7;
}

.publisherAC_box .publisherAC_clickableTitle a{
    color: #015ba7;
}

.publisherAC_box .publisherAC_hr {
    margin-top:0.3em;
    padding-top:0.2em;
}

.publisherAC_box .publisherAC_profilePic {
    width:16px;
    height:16px;
    padding-left:10px;
    padding-right:8px;
    vertical-align:top;
}

.publisherAC_box .publisherAC_expanded {
    background: transparent url(/img/feeds/arrow_sprite.png) no-repeat scroll 0 -8px;
    border: 0;
    height: 8px;
    width: 9px;
    margin-left:5px;
}
/*END:CSN Publisher*/



/* --------------------------------------------------------------------------------- */
/* Chatter Feed                                                                          */
/* --------------------------------------------------------------------------------- */
.feedcontainer {
    padding-bottom: 5px;
    line-height: 15px;
    max-width: 560px;
    overflow : visible;
}
.feedcontainer a {
    color:#015ba7;
    font-weight: normal;
    text-decoration:none;
}
.feedcontainer a:hover {
    text-decoration:underline;
}
.feedcontainer .feeditem span.unlinkedactor {
    color:#7d7d84;
}
.feedcontainer .feeditem .feedcommentuser a,
.feedcontainer .feeditem .feeditemfirstentity a,
.feedcontainer .feeditem .feeditemfirstentity,
.feedcontainer .feeditem .showmorefeeditemscontainer a,
.feedcontainer .feeditem .actorentitylink {
    font-weight: bold;
}
.feedcontainer .feeditem .feedcommentuser a,
.feedcontainer .feeditem .showmorefeeditemscontainer a,
.feedcontainer .feeditem a.actorentitylink {
    display: inline-block;
}
.feedcontainer .feeditem .feeditemwithsubject a.actorentitylink,
.feedcontainer .feeditem .feeditemsecondentity a,
.feedcontainer .feeditem .feeditemsecondentity span {
    font-weight: normal;
}

.feedcontainer .morechatterlink {
    display: block;
    margin-top: 15px;
    margin-bottom: 15px;
}

.feedcontainer ul.expandedchanges {
    list-style-type: disc;
    padding-left:40px;
    margin:12px 0;
}
.feedcontainer h3 {
    color:#666666;
    display:block;
    margin:0 0 8px 0;
    font-size:1.1em;
}

.feedcontainer .emptyfeed {
    margin-bottom: 5px;
}

.feedcontainer h3.feedtitle {
    font-size:1.2em;
    color:#222222;
    font-weight: 700;
    margin-bottom: 15px;
    line-height: 11px;
}
.feedcontainer .feedtitle a.feedtitletopiclink {
    font-weight: 700;
}
.feedFavoriteHeader h3.feedtitle a {
    font-weight: 700;
}
.feedtitle .alignleft {
    float: left;
}
.feedtitle .alignright {
    padding-top: 2px;
    float: right;
}
.feedtitle .alignright a {
    font-size:0.85em;
}

.feedcontainer .feedtitle .thisupdatespanarrow {
    display:inline-block;
    height:18px;
    width:6px;
    margin-right:6px;
    margin-left:6px;
}

.feedcontainer .feedtitle .thisupdatespanarrowimage_ltr {
     background:url("/img/chatter/divider.png") center no-repeat;
}

.feedcontainer .feedtitle .thisupdatespanarrowimage_rtl {
     background:url("/img/chatter/divider_rtl.png") center no-repeat;
}

.feedcontainer .feedtitle .allCompanyFilterHelpIcon {
    position: relative;
    display: inline;
    vertical-align: middle;
    margin-right:6px;
    margin-left:6px;       
}

.feedcontainer h3.feedtitle .mouseOverInfo {
    font-size:0.85em;
}

.feedcontainer h3 > span {
    font-weight:normal;
}
.feedcontainer .feeditem {
    min-height: 47px;
    white-space:normal;
    word-wrap:break-word;
    margin:0 10px 8px 0;
    padding:0 4px 8px 0;
    border-top:1px solid #fff;
    border-bottom:1px solid #e6e6e6;
}
.feedcontainer .checkedMenu a.checkedMenuButton {
    background-image: url("/img/feeds/menuArrows.png");
    padding-top: 0;
    padding-right: 16px;
    padding-bottom: 0;
    padding-left: 3px;
}
.feedcontainer .checkedMenu a.checkedMenuButton span {
    padding: 0;
}
.dropDownFilters {
    margin-bottom:15px;
}
#dropDownFeedFilters .checkedMenuLabel, #dropDownFeedFiltersButton{
    font-size:1.2em;
    font-weight:700;
}
#dropDownFeedFiltersLabel {
    display:inline-block;
    max-width:250px;
}
.dropDownFilters .checkedMenuMenuLink{
    display:inline-block;
    max-width:250px;
    overflow:hidden;
}
.feedcontainer .dropDownFilters .checkedMenu a.checkedMenuButton {
    background-position: right -50px;
    line-height: 15px;
    padding-left: 4px;
}
.feedcontainer .dropDownFilters .checkedMenuActivated a.checkedMenuButton {
    background-position: right -98px;
}
.feedcontainer .feedSortMenuContainer .checkedMenu a.checkedMenuButton {
    background-position: right -52px;
}
.feedcontainer .feedSortMenuContainer .checkedMenuActivated a.checkedMenuButton {
    background-position: right -100px;
}
.feedSortMenuContainer {
    margin-bottom: 15px;
    float: right;
}



/*CSS for rechat drop down list*/
.rechat {
	font-size:1.1em;
}
.feedcontainer .rechat.checkedMenu a.checkedMenuButton {
    padding-left: 0;
}
.rechat.checkedMenu a.checkedMenuButton {
    background-position: right 4px;
}
.rechat.checkedMenuActivated a.checkedMenuButton {
    background-position: right -20px;
}
.rechat .checkedMenuOptionContainer a {
	margin-left: 0;
}
/*CSS for rechat dialog box*/
.rechatDialog .middle {
	max-height: 450px;
	overflow-y: auto;	
}
.rechatClear {
	clear: both;
}
.rechatTitle{
	float: left;	
}
.rechatRecipientBlock{
	margin-top: 10px;	
	border-left: 1px solid #BFCFD4;
	border-right: 1px solid #BFCFD4;
	border-bottom: 1px solid #BFCFD4;
}
.rechatRecipientBlockTopCls{
	background: url("/img/alohaSkin/grid_headerbg.gif") repeat-x scroll 0 bottom #FFFFFF;
	border: 1px #BFCFD4 solid;
	border-left: none;
	border-right: none;
	color: #000000;
	font-size: 0.9em;
	font-weight: bold;
	padding: 5px;
}
.linkDirections {
	clear: both;
	margin-top: 10px;
}
.rechatItemRow, div.rechatCommandResponseContainer, div.rechatCustomerContainer {
	margin-top: 10px;
}
span.rechatDoc {
	margin-right: 5px;	
}
span.rechatDoc:hover{
	text-decoration: underline;	
}
.rechathelpLinkContainer {
	float: right;
	margin-top: 5px;
}
.rechatHelp {
	vertical-align: bottom;	
}
.rechatDoc {
	font-size: 0.9em;	
}
.rechatRecipientBottom  .members {
	margin-top: 3px;	
	font-weight: normal;
}
.rechatRecipientBottom img.groupicon{
	float:left;
	padding: 3px;
	position: relative;
	text-decoration: none;	
}
.rechatRecipientBottom a.remove{
	background: transparent url(/img/feeds/follow_sprite.png) no-repeat 0 -54px;
	no-repeat scroll left top transparent;
	height: 15px;
	width: 15px;
	position: relative;
	top: -15px;
	left: 380px;
	display: inline-block;	
}
.rechatRecipientBottom a.remove:hover{
	background: transparent url(/img/feeds/follow_sprite.png) no-repeat 0 -75px;
}
.rechatRecipientBottom .groupinfo {
	position: relative;
	top: 8px;
	left: 5px;
	font-weight: bold;
}
.composeRechatButtons {
	margin: 0 auto;
    margin-top: 10px;
	width: 200px;	
}
.rechatRecipientListCls {
	line-height: 22px;
	overflow: hidden;	
}
.rechatRecipientBottom .composeInput {
	border: 1px solid #959595;
	cursor: text;
	margin: 5px;
	width: 320px;
}
input.rechatUrlCls{
	width: 100%;
	padding: 0;
	border: none;
	height: 23px;
}
.rechatOkDialogButtonCls, .rechatClose {
	width: 50px;		
	text-align: center;
}
div.rechatCommandResponseContainer, div.rechatCustomerContainer{
	display:none;	
}
input.rechatRecipientInput{
	width: 100%;
	border: 0 none;
	height: 21px;
	margin: 0;
	padding: 0;	
}
div.urlBox{
	margin-top: 10px;
	padding: 4px 4px 3px 4px;
	border: 1px solid #959595;
	-moz-box-shadow: 0 1px 1px #D9D9D9 inset;		
	height: 23px;
}
input.ghostText{
	color: #7D7D84;
	font-size: 1em;
}
div.rechathelpLinkContainer  a.helpLinkElement {
	text-decoration: none;	
}
a.helpLinkElement {
	color: #015BA7;	
}
div.rechatCommandResponseContainer div.rechatCommandResponse {
	padding: 10px;
}
div.rechatCommandResponseContainer div.success{
	border: 1px solid #9bebb3;
	background: #edfff1;
}
div.rechatCommandResponseContainer div.failed{
	border: 1px solid #f2a199;
	background: #fdedea;
}
.rechatCustomerContainer, .rechatSecureLinkContainer {
	border: 1px solid #f8e38e;
	background: #ffffdc;		
}
.rechatGroupPrivateIcon {
    background:#FFFFFF url(/img/chatter/private_group_icon.gif) no-repeat scroll 0 0;
    position: absolute;
    top: 36px;
    left: 36px;
    border-bottom: 1px solid #D4DADC;
    border-right: 1px solid #D4DADC;
    width: 12px;
    height: 12px;	
}
.rechatCompanyIcon {
	background-image: url(/static/176/img/chatter/filters_sprite.png);
	width: 16px;	
	height: 16px;
	margin-right: 5px;
	vertical-align: middle;
	background-position: 0 -216px;
	display: inline-block;
	
}
div.rechatSecureLinkContainer {
	margin-top: 12px;	
	font-style: italic;	
	font-size: 0.9em;
}
.rechatCustomerContainer div.sharingStatusIcon img.warningIcon {
	background-image: url("/img/chatterfiles/chatterfiles16_sprite.png");
	background-repeat: no-repeat;
	height: 16px;
	width: 16px;
	background-position: 0 -200px;
}
.rechatCustomerContainer div.sharingStatusIcon {
	position: relative;
	float:left;
}
div.rechatCustomerContainer, div.rechatSecureLinkContainer {
	padding: 5px;
}
div.rechatCustomerWarningLabel {
	float: left;	
	margin-left: 10px;
}
span.rechatSuccessLink {
	word-wrap: break-word;	
}
.rechatCustomerContainer .sharingStatusIcon .warningIcon {
	width: 1px;
	height: 1px;	
}
/* Preview feed item styling */
.rechatPreviewContainer {
	margin-top: 15px;
	position: relative;
}
.rechatPreviewContainer .rechatPreviewElement {
	position: relative;
	z-index: 1;
	overflow: hidden;
	border-bottom: 0px;
}
.rechatPreviewContainer .rechatPreviewMaskElement {
	background-image: url("/img/empty.gif");
	position: absolute;
	height: 100%;
	width: 100%;
	z-index: 2;
	top:0;
	left:0;
}
.rechatPreviewContainer.feedcontainer .feeditem {
    border: 0;
}
.rechatPreviewContainer.feedcontainer .feeditemextras {
    margin-top: 18px;
}
.rechatPreviewContainer .rechatPreviewElement a {
    text-decoration: none;
    outline: 0;
}
.rechatPreviewContainer .rechatPreviewElement a:hover {
    cursor: default;
}
.rechatPreviewContainer .rechatPreviewElement textarea.cxnewcommenttext {
    max-height: 150px;
    overflow-y: auto;
}
.accessibleInlineMenuItems a {
	margin-right:5px;
}




/* Styles for publish to library badge */

.publishToLibBadgePanel {
    background-color: #AFC3CA;
    color: #fff;
    padding: 3px 4px 2px;
    text-align: center;
    border-radius: 3px;
    display: inline;
    font-size: 0.8em;
}

.chatterFileListBlock .publishToLibBadgePanel {
    display: inline-block;
    float: right;
}

.chatterFileListBlock .publishToLibBadgePanel.withMargin {
    margin: -17px 0 -1px;
}



/*BEGIN InfluenceBar*/

.influence-widget { 
 	font-size: 1em;
 	color: #7d7d84;
 	margin: 6px 0  0  0;
}

.hoverInfo .influence-widget { 
 	margin: 8px 0  0  0;
}

.influence-bar, .influence-header {
	width:  99%;
	overflow:hidden;
}

.influence-bar {
	height: 12px;
	border:	1px solid #c7ccce; 
	background: #f8f8f8;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    margin-top: 3px;
}

.influence-widget .section{
	height: 12px;
	border:	none; 
	float: left;
}

.influence-header .section{
	padding-bottom: 3px;
}

.influence-widget .observer{
	width:  25%;
	}

.influence-bar .active{
	border-left:	1px solid #c7ccce; 
}

.influence-widget .active{
	width:  55%;
}

.influence-widget .top{
	width:  20%;
	float:  right;
	margin-left: -3px;
}

.influence-bar .top{
	border-left:	1px solid #c7ccce; 
}	

.influence-bar .observer.highlight{
	 background:url("/img/chatter/influenceGradient.png") 0 0;
}

.influence-bar .active.highlight{
	background:url("/img/chatter/influenceGradient.png") 0 24px;
}

.influence-bar .top.highlight{
	background:url("/img/chatter/influenceGradient.png") 0 12px;
}

.influence-bar .marker{
	background:url("/img/chatter/youdot.png") no-repeat 0 0px;
	width: 12px;
	height: 12px;
	position: relative;
	left: 50%;
	margin-left: -6px;
}
 
 .influence-header {
 	margin: 0 0 3px;
 }
/*END InfluenceBar*/



/*-- Styles for publish to library dialog */

#FilePublishToLibraryDialog {
    position: absolute;
}

#FilePublishToLibraryDialogContent {
    min-height: 250px; 
    max-height: 420px;
}

#publishToLibContent {
    overflow: auto;
    padding-left: 10px;
    padding-right: 10px;
    padding-top: 10px;
    height: 380px;
    position: relative;
}

#FilePublishToLibraryDialogContent .buttonBar {
    padding-top: 15px;
}
#FilePublishToLibraryDialogContent .buttonBar .publishCancelButtons {
    width: 600px;
}

#global_form_error_msg ul {
    list-style: circle;
}

.publishToLibContentOverlayPanel .publishFormBlock .overlayListHeader {
    background: url("/img/alohaSkin/grid_headerbg.gif") repeat-x scroll 0 bottom #FFFFFF;
    border-bottom: 1px solid #DBDBDB;
    font-weight: bold;
    padding: 5px;
}

#publishToLibContent .publishFormHeader span {
    font-weight: bold;
}

#publishToLibContent .publishFormBlock {
    border: 1px solid #DBDBDB;
    padding-bottom: 5px;
    display: table;
    width: 100%;
}

#publishToLibContent .publishToLibCommonFieldsPlaceHolder {
    height: 24px;
}

.publishToLibCommonFieldsContainer {
    width: 100%;
}

.stdInformationSectionHelpTextPanel {
    vertical-align: top;
}

.stdInformationSectionHelpText {
    width: 200px;
    float: right;
    font-size: 1.1em;
    padding: 5px 2px 0;
}

.stdInformationSectionHelpText .helpLink {
    text-decoration: underline;
}

.publishToLibCommonFields td, .publishToLibCommonFields th {
    padding: 4px 3px;
}

.publishToLibCommonFields .requiredInput {
    position: relative;
}
.publishToLibCommonFields .requiredInput .requiredBlock {
    background-color: #CC0000;
    bottom: 0;
    left: -4px;
    position: absolute;
    top: 1px;
    width: 3px;
}

.publishToLibCommonFields .publishInputNormalSize {
    width: 342px;
}

.publishToLibCommonFields .publishDescripiton {
    resize: none;
}

.publishToLibCommonFields select.publishInputNormalSize {
    width: 220px;
}

.publishToLibCommonFields .publishToLibLabelCell {
    vertical-align: top;
    text-align: right;
    color: #4A4A56;
    font-weight: bold;
    width: 120px;
}

#publishFancyTagsContainer {
    cursor: text;
    padding: 2px 4px;
    border: 1px solid #959595;
    -moz-box-shadow: 0 1px 1px #D9D9D9 inset;
    width: 334px;
    background-color: #FFFFFF;
}

#publishFancyTagsList input {
    border: 0 none;
    height: 16px;
    margin: 0;
    padding: 0;
    max-width: 320px;
    margin-top: 1px;
}

#publishFancyTagsList .tagItem {
    -moz-border-radius: 4px 4px 4px 4px;
    background: none repeat scroll 0 0 #EEF7FA;
    border: 1px solid #D4DADC;
    color: #222222;
    padding: 2px 5px 1px;
    text-decoration: none;
    font-size: 0.92em;
    display: inline-block;
    margin: 1px 0;
}

#publishFancyTagsList .tagItem .tagItemText {
    max-width: 300px;
    overflow: hidden;
    display: inline-block;
    white-space: nowrap;
    float: left;
    margin: -2px 0 -2px;
    text-overflow: ellipsis;
}

#publishFancyTagsList .tagItemInputContainer {
    display: inline-block;
}
    
#publishFancyTagsList span {
    padding: 2px 0;
}

#publishFancyTagsList a {
    margin-left: 5px;
    padding-top: 2px;
    display: inline-block;
}

#publishFancyTagsList a.remove img {
    background: url("/img/chatter/message_item_x.png") no-repeat scroll left top transparent;
    height: 8px;
    width: 8px;
    border: 0 none;
}

.tagACList {
    list-style-image:none;
    list-style-position:outside;
    list-style-type:none;
    padding:0;
    margin:0;
}

.tagACList li {
    margin:0;
}

.tagACRow {
    height: 16px;
    padding-left: 2px;
}

.tagACRowSelected {
    padding-left: 2px;
    height: 16px;
}

.tagACRowHover {
    color:#015ba7;
    background-color: #e3f3ff;
}

.tagACRow.tagACHintRow {
    background-color: #F7F8F8;
    text-align: center;
    padding-top: 5px;
    font-weight: bold;
    height: 25px;
    cursor: default;
}

#publishCustomFieldsBlock {
    margin-top: 10px;
    border-top: 1px solid #EAEAEA;
}

#customFieldsBody {
    margin-top: 5px;
}

#customFieldsBody .bPageBlock {
    border: none;
}

#customFieldsBody .detailList .helpOrb {
    right: -21px;    
}

.requiredLegend_publish {
    float: left;
    display: inline;
}

#customFieldsBody .mouseOverInfo {
    left: -245px;
}

#customFieldsBody .helpOrb {
    background-image: url("/img/alohaSkin/info_sprite.png");
    background-position: left top;
    height: 15px;
    width: 15px;                
}

#customFieldsBody .requiredInput {
    margin-left: 4px;                
}

#gotoContentLinkBox {
    margin-top: 3px;
    color: #7D7D84;
}

#FilePublishToLibraryDialogContent .publishProgress {
    background: url(/img/loading32.gif) no-repeat 0 0;
    float: left;
    width: 32px;
    height: 32px;
}

#FilePublishToLibraryDialogContent .publishProgressPanel {
    margin: 100px 150px;
}

#FilePublishToLibraryDialogContent .publishText {
    font-size: 1.05em;
    padding: 5px 45px;
}



/* Styles for action progress dialog */

#actionProgressPanel #contentContainer {
    width : 442px;
}

#actionProgressPanel #progressIcon {
    background: url(/img/loading32.gif) no-repeat 0 0;
    float : left;
    width : 32px;
    height : 32px;
    margin-top : 10px;
}

#actionProgressPanel #progressMsgContainer {
    float : left;
    width : 395px;
    padding-left : 10px;
}

#progressMsgContainer #progressMsgTitle {
    font-size: 1.2em;
    font-weight : bold;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

#progressMsgContainer #progressMsgText {
    padding-top : 10px;
}

#actionProgressPanel .clear {
    clear : both;
}



