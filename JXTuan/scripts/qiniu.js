let qiniu = require('qiniu');
let accessKey = '';
let secretKey = '';
let bucket = '';
let TuanIdURL = '';
accessKey = process.env.QINIU_AK
secretKey = process.env.QINIU_SK
bucket = process.env.QINIU_BUCKET
TuanIdURL = process.env.QINIU_URL

var mac = new qiniu.auth.digest.Mac(accessKey, secretKey);
var keyToOverwrite = 'jd_updateFactoryTuanId.json';
var options = {
    scope: bucket + ":" + keyToOverwrite,
    expires: 1
}
var putPolicy = new qiniu.rs.PutPolicy(options);
var uploadToken=putPolicy.uploadToken(mac);
var config = new qiniu.conf.Config();
config.zone = qiniu.zone.Zone_z2;
var localFile = "./jd_updateFactoryTuanId.json";
var formUploader = new qiniu.form_up.FormUploader(config);
var putExtra = new qiniu.form_up.PutExtra();
var key='jd_updateFactoryTuanId.json';

// 文件上传
formUploader.putFile(uploadToken, key, localFile, putExtra, function(respErr, respBody, respInfo) {
    if (respErr) {
        throw respErr;
    }
    if (respInfo.statusCode == 200) {
        console.log(respBody);
    } else {
        console.log(respInfo.statusCode);
        console.log(respBody);
    }
});

// 文件刷新
var cdnManager = new qiniu.cdn.CdnManager(mac);
var urlsToRefresh = [TuanIdURL];

//刷新链接
cdnManager.refreshUrls(urlsToRefresh, function(err, respBody, respInfo) {
    if (err) {
        throw err;
    }
    console.log(respInfo.statusCode);
});