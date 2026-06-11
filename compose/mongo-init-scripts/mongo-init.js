postsDb = db.getSiblingDB('rure_sub_posts');

postsDb.createCollection('posts');
postsDb.createCollection('inbox_messages');

commentsDb = db.getSiblingDB('rure_sub_comments');

commentsDb.createCollection('comments');
commentsDb.createCollection('inbox_messages');
