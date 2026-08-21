# FanRank V15.3

Bug-fix build. The V15 state object is initialized before startup handlers,
so a JavaScript ReferenceError cannot prevent the navigation handlers from
being registered.

Based on the working FanRank interface. No new SQL is required.
