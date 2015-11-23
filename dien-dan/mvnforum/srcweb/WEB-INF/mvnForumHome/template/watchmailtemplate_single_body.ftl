mobi8 Tóm tắt hoạt động
Số lượng bài mới từ : ${lastSent}
Cập nhật lúc : ${now}
---------------------------------------
Để cập nhật thông tin mới nhất, vui lòng truy cập : ${forumBase}/index
---------------------------------------

<#if threadWatch.leader >
[Nhóm diễn đàn: ${threadWatch.categoryName}] [Diễn đàn: ${threadWatch.forumName}]
</#if>
    Chủ đề [${threadWatch.threadTopic}] được gửi bởi ${threadWatch.memberName}
      có bài gửi mới nhất bởi ${threadWatch.lastPostMemberName} lúc ${threadWatch.threadLastPostDate}
      ${threadWatch.threadUrl}

Chủ đề gần nhất : ${threadWatch.threadBody}
Bài viết mới nhất : ${threadWatch.lastPostTopic}
Nội dung bài viết mới nhất : ${threadWatch.lastPostBody}
Địa chỉ truy cập bài viết mới nhất : ${threadWatch.lastPostUrl}

Đây không phải thư rác. Nếu bạn không muốn nhận thư này, vui lòng truy cập : ${forumBase}/mywatch