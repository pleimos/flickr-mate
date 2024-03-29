//
// ObjectiveFlickr.h
//
// Copyright (c) 2009 Lukhnos D. Liu (http://lukhnos.org)
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//

#import "LFWebAPIKit.h"
#import "OFUtilities.h"
#import "OFXMLMapper.h"

extern NSString *const OFFlickrSmallSquareSize;		// "s" - 75x75
extern NSString *const OFFlickrThumbnailSize;		// "t" - 100 on longest side
extern NSString *const OFFlickrSmallSize;			// "m" - 240 on longest side
extern NSString *const OFFlickrMediumSize;			// (no size modifier) - 500 on longest side
extern NSString *const OFFlickrLargeSize;			// "b" - 1024 on longest side

extern NSString *const OFFlickrReadPermission;
extern NSString *const OFFlickrWritePermission;
extern NSString *const OFFlickrDeletePermission;

@interface OFFlickrAPIContext : NSObject
{
    NSString *key;
    NSString *sharedSecret;
    NSString *authToken;
    
    NSString *RESTAPIEndpoint;
	NSString *photoSource;
	NSString *photoWebPageSource;
	NSString *authEndpoint;
    NSString *uploadEndpoint;
    
    NSString *oauthToken;
    NSString *oauthTokenSecret;
}
- (id)initWithAPIKey:(NSString *)inKey sharedSecret:(NSString *)inSharedSecret;

// OAuth URL
- (NSURL *)userAuthorizationURLWithRequestToken:(NSString *)inRequestToken requestedPermission:(NSString *)inPermission;


// URL provisioning
- (NSURL *)photoSourceURLFromDictionary:(NSDictionary *)inDictionary size:(NSString *)inSizeModifier;
- (NSURL *)photoWebPageURLFromDictionary:(NSDictionary *)inDictionary;
- (NSURL *)loginURLFromFrobDictionary:(NSDictionary *)inFrob requestedPermission:(NSString *)inPermission;

// API endpoints

#if MAC_OS_X_VERSION_MIN_REQUIRED > MAC_OS_X_VERSION_10_4
@property (nonatomic, readonly) NSString *key;
@property (nonatomic, readonly) NSString *sharedSecret;
@property (nonatomic, strong) NSString *authToken;

@property (nonatomic, strong) NSString *RESTAPIEndpoint;
@property (nonatomic, strong) NSString *photoSource;
@property (nonatomic, strong) NSString *photoWebPageSource;
@property (nonatomic, strong) NSString *authEndpoint;
@property (nonatomic, strong) NSString *uploadEndpoint;

@property (nonatomic, strong) NSString *OAuthToken;
@property (nonatomic, strong) NSString *OAuthTokenSecret;
#else

- (void)setAuthToken:(NSString *)inAuthToken;
- (NSString *)authToken;


- (void)setRESTAPIEndpoint:(NSString *)inEndpoint;
- (NSString *)RESTAPIEndpoint;

- (void)setPhotoSource:(NSString *)inSource;
- (NSString *)photoSource;

- (void)setAuthEndpoint:(NSString *)inEndpoint;
- (NSString *)authEndpoint;

- (void)setUploadEndpoint:(NSString *)inEndpoint;
- (NSString *)uploadEndpoint;

- (void)setOAuthToken:(NSString *)inToken;
- (NSString *)OAuthToken;

- (void)setOAuthTokenSecret:(NSString *)inTokenSecret;
- (NSString *)OAuthTokenSecret;


#endif
@end

extern NSString *const OFFlickrAPIReturnedErrorDomain;
extern NSString *const OFFlickrAPIRequestErrorDomain;

enum {
	// refer to Flickr API document for Flickr's own error codes
    OFFlickrAPIRequestConnectionError = 0x7fff0001,
    OFFlickrAPIRequestTimeoutError = 0x7fff0002,    
	OFFlickrAPIRequestFaultyXMLResponseError = 0x7fff0003,
    
    OFFlickrAPIRequestOAuthError = 0x7fff0004,

    OFFlickrAPIRequestUnknownError = 0x7fff0042    
};

extern NSString *const OFFlickrAPIRequestOAuthErrorUserInfoKey;

extern NSString *const OFFetchOAuthRequestTokenSession;
extern NSString *const OFFetchOAuthAccessTokenSession;


@class OFFlickrAPIRequest;

#if MAC_OS_X_VERSION_MAX_ALLOWED > MAC_OS_X_VERSION_10_4
@protocol OFFlickrAPIRequestDelegate <NSObject>
@optional
#else
@interface NSObject (OFFlickrAPIRequestDelegateCategory)
#endif
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary;
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError;
#if MAC_OS_X_VERSION_MAX_ALLOWED > MAC_OS_X_VERSION_10_4                
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest imageUploadSentBytes:(NSUInteger)inSentBytes totalBytes:(NSUInteger)inTotalBytes;
#else
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest imageUploadSentBytes:(unsigned int)inSentBytes totalBytes:(unsigned int)inTotalBytes;
#endif

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didObtainOAuthRequestToken:(NSString *)inRequestToken secret:(NSString *)inSecret;
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didObtainOAuthAccessToken:(NSString *)inAccessToken secret:(NSString *)inSecret userFullName:(NSString *)inFullName userName:(NSString *)inUserName userNSID:(NSString *)inNSID;

@end

#if MAC_OS_X_VERSION_MAX_ALLOWED > MAC_OS_X_VERSION_10_4
typedef id<OFFlickrAPIRequestDelegate> OFFlickrAPIRequestDelegateType;
#else
typedef id OFFlickrAPIRequestDelegateType;
#endif

@interface OFFlickrAPIRequest : NSObject
{
    OFFlickrAPIContext *context;
    LFHTTPRequest *HTTPRequest;
    
    OFFlickrAPIRequestDelegateType delegate;
    id sessionInfo;
    
    NSString *uploadTempFilename;
    
    id oauthState;
}
- (id)initWithAPIContext:(OFFlickrAPIContext *)inContext;
- (OFFlickrAPIContext *)context;


- (NSTimeInterval)requestTimeoutInterval;
- (void)setRequestTimeoutInterval:(NSTimeInterval)inTimeInterval;
- (BOOL)isRunning;
- (void)cancel;

// oauth methods
- (BOOL)fetchOAuthRequestTokenWithCallbackURL:(NSURL *)inCallbackURL;
- (BOOL)fetchOAuthAccessTokenWithRequestToken:(NSString *)inRequestToken verifier:(NSString *)inVerifier;


// elementary methods
- (BOOL)callAPIMethodWithGET:(NSString *)inMethodName arguments:(NSDictionary *)inArguments;
- (BOOL)callAPIMethodWithPOST:(NSString *)inMethodName arguments:(NSDictionary *)inArguments;

// image upload—we use NSInputStream here because we want to have flexibity; with this you can upload either a file or NSData from NSImage
- (BOOL)uploadImageStream:(NSInputStream *)inImageStream suggestedFilename:(NSString *)inFilename MIMEType:(NSString *)inType arguments:(NSDictionary *)inArguments;

#if MAC_OS_X_VERSION_MAX_ALLOWED > MAC_OS_X_VERSION_10_4
@property (unsafe_unretained, nonatomic, readonly) OFFlickrAPIContext *context;
@property (nonatomic, unsafe_unretained) OFFlickrAPIRequestDelegateType delegate;
@property (nonatomic, strong) id sessionInfo;
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;
#else

- (OFFlickrAPIRequestDelegateType)delegate;
- (void)setDelegate:(OFFlickrAPIRequestDelegateType)inDelegate;

- (id)sessionInfo;
- (void)setSessionInfo:(id)inInfo;

#endif

@end
