//
//  ARTrailSummaryMapViewController.m
//  AROne
//
//  Created by Jerry Wu on 2/10/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARTrailSummaryMapViewController.h"
#import "ARTrailSummaryViewController.h"
#import "trailPathView.h"
#import "ARTrailPoint.h"


@interface ARTrailSummaryMapViewController () <UIScrollViewDelegate, trailPathSource>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *imageView;
@property BOOL zoomed;
@property BOOL trailOn;
@property (nonatomic) trailPathView* trailPath;
@property (nonatomic) UIImage * map;

@end

@implementation ARTrailSummaryMapViewController

#pragma mark - trailPathSource methods

- (NSArray *)trailPathViewData:(trailPathView *)graphView
{
  NSArray *googleMap_Lamberjack = [[NSArray alloc] initWithObjects:
                                   [[NSArray alloc] initWithObjects:@"7595", @"39.25188056", @"120.1316417", nil],
                                   [[NSArray alloc] initWithObjects:@"7590", @"39.25197222", @"120.1316083", nil],
                                   [[NSArray alloc] initWithObjects:@"7585", @"39.25203333", @"120.1315861", nil],
                                   [[NSArray alloc] initWithObjects:@"7580", @"39.25209444", @"120.1315639", nil],
                                   [[NSArray alloc] initWithObjects:@"7575", @"39.25214722", @"120.1315472", nil],
                                   [[NSArray alloc] initWithObjects:@"7570", @"39.252225", @"120.1315083", nil],
                                   [[NSArray alloc] initWithObjects:@"7565", @"39.25232222", @"120.13145", nil],
                                   [[NSArray alloc] initWithObjects:@"7560", @"39.25238889", @"120.1314111", nil],
                                   [[NSArray alloc] initWithObjects:@"7555", @"39.25245833", @"120.1313806", nil],
                                   [[NSArray alloc] initWithObjects:@"7550", @"39.25256111", @"120.1313417", nil],
                                   [[NSArray alloc] initWithObjects:@"7545", @"39.252675", @"120.1313028", nil],
                                   [[NSArray alloc] initWithObjects:@"7540", @"39.252775", @"120.1312556", nil],
                                   [[NSArray alloc] initWithObjects:@"7535", @"39.25285278", @"120.1312194", nil],
                                   [[NSArray alloc] initWithObjects:@"7530", @"39.25293611", @"120.1311972", nil],
                                   [[NSArray alloc] initWithObjects:@"7525", @"39.253", @"120.1311806", nil],
                                   [[NSArray alloc] initWithObjects:@"7520", @"39.25305278", @"120.1311694", nil],
                                   [[NSArray alloc] initWithObjects:@"7515", @"39.25310278", @"120.1311583", nil],
                                   [[NSArray alloc] initWithObjects:@"7510", @"39.25315556", @"120.1311472", nil],
                                   [[NSArray alloc] initWithObjects:@"7505", @"39.25320833", @"120.131125", nil],
                                   [[NSArray alloc] initWithObjects:@"7500", @"39.25325833", @"120.1311056", nil],
                                   [[NSArray alloc] initWithObjects:@"7495", @"39.25330833", @"120.1310861", nil],
                                   [[NSArray alloc] initWithObjects:@"7490", @"39.25335", @"120.1310722", nil],
                                   [[NSArray alloc] initWithObjects:@"7485", @"39.25343056", @"120.1310333", nil],
                                   [[NSArray alloc] initWithObjects:@"7480", @"39.25349722", @"120.131", nil],
                                   [[NSArray alloc] initWithObjects:@"7475", @"39.25354722", @"120.130975", nil],
                                   [[NSArray alloc] initWithObjects:@"7470", @"39.25359722", @"120.13095", nil],
                                   [[NSArray alloc] initWithObjects:@"7465", @"39.25377778", @"120.1308667", nil],
                                   [[NSArray alloc] initWithObjects:@"7460", @"39.25384722", @"120.1308361", nil],
                                   [[NSArray alloc] initWithObjects:@"7455", @"39.25390833", @"120.1308139", nil],
                                   [[NSArray alloc] initWithObjects:@"7450", @"39.25396111", @"120.1308083", nil],
                                   [[NSArray alloc] initWithObjects:@"7445", @"39.25401389", @"120.1308", nil],
                                   [[NSArray alloc] initWithObjects:@"7440", @"39.25407778", @"120.1307917", nil],
                                   [[NSArray alloc] initWithObjects:@"7435", @"39.25416389", @"120.1307806", nil],
                                   [[NSArray alloc] initWithObjects:@"7430", @"39.25424722", @"120.1307694", nil],
                                   [[NSArray alloc] initWithObjects:@"7425", @"39.25432222", @"120.1307694", nil],
                                   [[NSArray alloc] initWithObjects:@"7420", @"39.25438611", @"120.1307667", nil],
                                   [[NSArray alloc] initWithObjects:@"7415", @"39.25446944", @"120.1307667", nil],
                                   [[NSArray alloc] initWithObjects:@"7410", @"39.25453333", @"120.1307667", nil],
                                   [[NSArray alloc] initWithObjects:@"7405", @"39.25460556", @"120.1307389", nil],
                                   [[NSArray alloc] initWithObjects:@"7400", @"39.25466667", @"120.1307139", nil],
                                   [[NSArray alloc] initWithObjects:@"7395", @"39.254725", @"120.1306889", nil],
                                   [[NSArray alloc] initWithObjects:@"7390", @"39.25478889", @"120.1306694", nil],
                                   [[NSArray alloc] initWithObjects:@"7385", @"39.25484167", @"120.1306583", nil],
                                   [[NSArray alloc] initWithObjects:@"7380", @"39.25489444", @"120.13065", nil],
                                   [[NSArray alloc] initWithObjects:@"7375", @"39.25495556", @"120.1306361", nil],
                                   [[NSArray alloc] initWithObjects:@"7370", @"39.25500833", @"120.1306278", nil],
                                   [[NSArray alloc] initWithObjects:@"7365", @"39.25505556", @"120.1305972", nil],
                                   [[NSArray alloc] initWithObjects:@"7360", @"39.25509722", @"120.1305556", nil],
                                   [[NSArray alloc] initWithObjects:@"7355", @"39.25513056", @"120.1305222", nil],
                                   [[NSArray alloc] initWithObjects:@"7350", @"39.25518056", @"120.1304722", nil],
                                   [[NSArray alloc] initWithObjects:@"7345", @"39.25525556", @"120.1303944", nil],
                                   [[NSArray alloc] initWithObjects:@"7340", @"39.25530833", @"120.1303306", nil],
                                   [[NSArray alloc] initWithObjects:@"7335", @"39.25535556", @"120.130275", nil],
                                   [[NSArray alloc] initWithObjects:@"7330", @"39.25540278", @"120.1302194", nil],
                                   [[NSArray alloc] initWithObjects:@"7325", @"39.25555833", @"120.1298972", nil],
                                   [[NSArray alloc] initWithObjects:@"7320", @"39.25564444", @"120.1297611", nil],
                                   [[NSArray alloc] initWithObjects:@"7315", @"39.25569167", @"120.1297083", nil],
                                   [[NSArray alloc] initWithObjects:@"7310", @"39.25575", @"120.1296472", nil],
                                   [[NSArray alloc] initWithObjects:@"7305", @"39.2558", @"120.1295972", nil],
                                   [[NSArray alloc] initWithObjects:@"7300", @"39.25585278", @"120.1295306", nil],
                                   [[NSArray alloc] initWithObjects:@"7295", @"39.25600278", @"120.1293556", nil],
                                   [[NSArray alloc] initWithObjects:@"7290", @"39.25605833", @"120.1293139", nil],
                                   [[NSArray alloc] initWithObjects:@"7285", @"39.25611111", @"120.129275", nil],
                                   [[NSArray alloc] initWithObjects:@"7280", @"39.25616667", @"120.1292333", nil],
                                   [[NSArray alloc] initWithObjects:@"7275", @"39.25624167", @"120.1291778", nil],
                                   [[NSArray alloc] initWithObjects:@"7270", @"39.25630278", @"120.1291278", nil],
                                   [[NSArray alloc] initWithObjects:@"7265", @"39.25635", @"120.1290917", nil],
                                   [[NSArray alloc] initWithObjects:@"7260", @"39.25639444", @"120.1290556", nil],
                                   [[NSArray alloc] initWithObjects:@"7255", @"39.25644722", @"120.1290111", nil],
                                   [[NSArray alloc] initWithObjects:@"7250", @"39.25651944", @"120.1289833", nil],
                                   [[NSArray alloc] initWithObjects:@"7245", @"39.25658056", @"120.1289583", nil],
                                   [[NSArray alloc] initWithObjects:@"7240", @"39.25661944", @"120.1289444", nil],
                                   [[NSArray alloc] initWithObjects:@"7235", @"39.25668056", @"120.1289194", nil],
                                   [[NSArray alloc] initWithObjects:@"7230", @"39.25676389", @"120.1288972", nil],
                                   [[NSArray alloc] initWithObjects:@"7225", @"39.25683889", @"120.1288889", nil],
                                   [[NSArray alloc] initWithObjects:@"7220", @"39.25690278", @"120.1288806", nil],
                                   [[NSArray alloc] initWithObjects:@"7215", @"39.25696667", @"120.1288722", nil],
                                   [[NSArray alloc] initWithObjects:@"7210", @"39.25701944", @"120.128875", nil],
                                   [[NSArray alloc] initWithObjects:@"7205", @"39.25709167", @"120.1288806", nil],
                                   [[NSArray alloc] initWithObjects:@"7200", @"39.2572", @"120.1288861", nil],
                                   [[NSArray alloc] initWithObjects:@"7195", @"39.25729444", @"120.1288889", nil],
                                   [[NSArray alloc] initWithObjects:@"7190", @"39.25736944", @"120.1288917", nil],
                                   [[NSArray alloc] initWithObjects:@"7185", @"39.25745278", @"120.1288972", nil],
                                   [[NSArray alloc] initWithObjects:@"7180", @"39.25753889", @"120.1288944", nil],
                                   [[NSArray alloc] initWithObjects:@"7175", @"39.25762222", @"120.1288889", nil],
                                   [[NSArray alloc] initWithObjects:@"7170", @"39.25770833", @"120.1288861", nil],
                                   [[NSArray alloc] initWithObjects:@"7165", @"39.25780278", @"120.1288694", nil],
                                   [[NSArray alloc] initWithObjects:@"7160", @"39.25790278", @"120.1288278", nil],
                                   [[NSArray alloc] initWithObjects:@"7155", @"39.25799444", @"120.1287917", nil],
                                   [[NSArray alloc] initWithObjects:@"7150", @"39.25808611", @"120.1287528", nil],
                                   [[NSArray alloc] initWithObjects:@"7145", @"39.25815556", @"120.128725", nil],
                                   [[NSArray alloc] initWithObjects:@"7140", @"39.25837222", @"120.1286472", nil],
                                   [[NSArray alloc] initWithObjects:@"7135", @"39.258475", @"120.1286194", nil],
                                   [[NSArray alloc] initWithObjects:@"7130", @"39.25852778", @"120.1286028", nil],
                                   [[NSArray alloc] initWithObjects:@"7125", @"39.25857778", @"120.1285889", nil],
                                   [[NSArray alloc] initWithObjects:@"7120", @"39.25864167", @"120.1285722", nil],
                                   [[NSArray alloc] initWithObjects:@"7115", @"39.25871389", @"120.1285472", nil],
                                   [[NSArray alloc] initWithObjects:@"7110", @"39.25881667", @"120.1285111", nil],
                                   [[NSArray alloc] initWithObjects:@"7105", @"39.25890833", @"120.1284778", nil],
                                   [[NSArray alloc] initWithObjects:@"7100", @"39.25898889", @"120.1284444", nil],
                                   [[NSArray alloc] initWithObjects:@"7095", @"39.25905278", @"120.1283972", nil],
                                   [[NSArray alloc] initWithObjects:@"7090", @"39.25911667", @"120.12835", nil],
                                   [[NSArray alloc] initWithObjects:@"7085", @"39.25918056", @"120.1283028", nil],
                                   [[NSArray alloc] initWithObjects:@"7080", @"39.25933333", @"120.1282028", nil],
                                   [[NSArray alloc] initWithObjects:@"7075", @"39.25942778", @"120.1281417", nil],
                                   [[NSArray alloc] initWithObjects:@"7070", @"39.25949722", @"120.1281083", nil],
                                   [[NSArray alloc] initWithObjects:@"7065", @"39.25958056", @"120.1280889", nil],
                                   [[NSArray alloc] initWithObjects:@"7060", @"39.25969167", @"120.1280667", nil],
                                   [[NSArray alloc] initWithObjects:@"7055", @"39.25978056", @"120.1280444", nil],
                                   [[NSArray alloc] initWithObjects:@"7050", @"39.259875", @"120.1280278", nil],
                                   nil];
  NSArray *googleMap_LowerMainStreet = [[NSArray alloc] initWithObjects:
                                        [[NSArray alloc] initWithObjects:@"7047", @"39.25998889", @"120.1279056", nil],
                                        [[NSArray alloc] initWithObjects:@"7042", @"39.26004722", @"120.1278639", nil],
                                        [[NSArray alloc] initWithObjects:@"7037", @"39.26011111", @"120.1278194", nil],
                                        [[NSArray alloc] initWithObjects:@"7032", @"39.26018333", @"120.1277694", nil],
                                        [[NSArray alloc] initWithObjects:@"7027", @"39.26024167", @"120.1277278", nil],
                                        [[NSArray alloc] initWithObjects:@"7022", @"39.26033056", @"120.1276639", nil],
                                        [[NSArray alloc] initWithObjects:@"7017", @"39.26041667", @"120.1276056", nil],
                                        [[NSArray alloc] initWithObjects:@"7012", @"39.26049167", @"120.1275556", nil],
                                        [[NSArray alloc] initWithObjects:@"7007", @"39.26057222", @"120.1275028", nil],
                                        [[NSArray alloc] initWithObjects:@"7002", @"39.26064444", @"120.1274556", nil],
                                        [[NSArray alloc] initWithObjects:@"6997", @"39.26070278", @"120.1274194", nil],
                                        [[NSArray alloc] initWithObjects:@"6992", @"39.26078333", @"120.1273667", nil],
                                        [[NSArray alloc] initWithObjects:@"6987", @"39.26084722", @"120.127325", nil],
                                        [[NSArray alloc] initWithObjects:@"6982", @"39.26090278", @"120.1272917", nil],
                                        [[NSArray alloc] initWithObjects:@"6977", @"39.26095556", @"120.1272528", nil],
                                        [[NSArray alloc] initWithObjects:@"6972", @"39.261", @"120.1272222", nil],
                                        [[NSArray alloc] initWithObjects:@"6967", @"39.26104167", @"120.1271917", nil],
                                        [[NSArray alloc] initWithObjects:@"6962", @"39.26108333", @"120.1271611", nil],
                                        [[NSArray alloc] initWithObjects:@"6957", @"39.26112778", @"120.1271306", nil],
                                        [[NSArray alloc] initWithObjects:@"6952", @"39.26115833", @"120.1271083", nil],
                                        [[NSArray alloc] initWithObjects:@"6947", @"39.26118889", @"120.1270861", nil],
                                        [[NSArray alloc] initWithObjects:@"6942", @"39.26121944", @"120.1270639", nil],
                                        [[NSArray alloc] initWithObjects:@"6937", @"39.26125", @"120.1270417", nil],
                                        [[NSArray alloc] initWithObjects:@"6932", @"39.261275", @"120.127025", nil],
                                        [[NSArray alloc] initWithObjects:@"6927", @"39.26130556", @"120.127", nil],
                                        [[NSArray alloc] initWithObjects:@"6922", @"39.26135278", @"120.1269667", nil],
                                        [[NSArray alloc] initWithObjects:@"6917", @"39.26142222", @"120.1269167", nil],
                                        [[NSArray alloc] initWithObjects:@"6912", @"39.26148333", @"120.1268722", nil],
                                        [[NSArray alloc] initWithObjects:@"6907", @"39.261525", @"120.1268417", nil],
                                        [[NSArray alloc] initWithObjects:@"6902", @"39.26156389", @"120.1268139", nil],
                                        [[NSArray alloc] initWithObjects:@"6897", @"39.2616", @"120.1267889", nil],
                                        [[NSArray alloc] initWithObjects:@"6892", @"39.26164722", @"120.1267556", nil],
                                        [[NSArray alloc] initWithObjects:@"6887", @"39.26171667", @"120.1267056", nil],
                                        [[NSArray alloc] initWithObjects:@"6882", @"39.26178333", @"120.1266361", nil],
                                        [[NSArray alloc] initWithObjects:@"6877", @"39.26183889", @"120.1265833", nil],
                                        [[NSArray alloc] initWithObjects:@"6872", @"39.26188889", @"120.1265306", nil],
                                        [[NSArray alloc] initWithObjects:@"6867", @"39.26193056", @"120.1264889", nil],
                                        [[NSArray alloc] initWithObjects:@"6862", @"39.262", @"120.1264194", nil],
                                        [[NSArray alloc] initWithObjects:@"6857", @"39.26204167", @"120.126375", nil],
                                        nil];
  NSArray *googleMap_MagicMoguls = [[NSArray alloc] initWithObjects:
                                    [[NSArray alloc] initWithObjects:@"7943", @"39.24862222", @"120.1276167", nil],
                                    [[NSArray alloc] initWithObjects:@"7938", @"39.24867778", @"120.1276639", nil],
                                    [[NSArray alloc] initWithObjects:@"7933", @"39.24873889", @"120.1277167", nil],
                                    [[NSArray alloc] initWithObjects:@"7928", @"39.24882222", @"120.1277889", nil],
                                    [[NSArray alloc] initWithObjects:@"7923", @"39.24890556", @"120.1278611", nil],
                                    [[NSArray alloc] initWithObjects:@"7918", @"39.248975", @"120.1279361", nil],
                                    [[NSArray alloc] initWithObjects:@"7913", @"39.24903611", @"120.1280028", nil],
                                    [[NSArray alloc] initWithObjects:@"7908", @"39.24910278", @"120.128075", nil],
                                    [[NSArray alloc] initWithObjects:@"7903", @"39.24917778", @"120.1281583", nil],
                                    [[NSArray alloc] initWithObjects:@"7898", @"39.24924722", @"120.128225", nil],
                                    [[NSArray alloc] initWithObjects:@"7893", @"39.24930278", @"120.1282556", nil],
                                    [[NSArray alloc] initWithObjects:@"7888", @"39.24936389", @"120.1282889", nil],
                                    [[NSArray alloc] initWithObjects:@"7883", @"39.24945556", @"120.1283361", nil],
                                    [[NSArray alloc] initWithObjects:@"7878", @"39.24953611", @"120.1283806", nil],
                                    [[NSArray alloc] initWithObjects:@"7873", @"39.24961389", @"120.1284222", nil],
                                    [[NSArray alloc] initWithObjects:@"7868", @"39.24974722", @"120.128475", nil],
                                    [[NSArray alloc] initWithObjects:@"7863", @"39.24984444", @"120.1285111", nil],
                                    [[NSArray alloc] initWithObjects:@"7858", @"39.24993333", @"120.1285444", nil],
                                    [[NSArray alloc] initWithObjects:@"7853", @"39.25002778", @"120.1286139", nil],
                                    [[NSArray alloc] initWithObjects:@"7848", @"39.2501", @"120.1287167", nil],
                                    [[NSArray alloc] initWithObjects:@"7843", @"39.25015278", @"120.1287917", nil],
                                    [[NSArray alloc] initWithObjects:@"7838", @"39.25020556", @"120.1288667", nil],
                                    [[NSArray alloc] initWithObjects:@"7833", @"39.25026389", @"120.12895", nil],
                                    [[NSArray alloc] initWithObjects:@"7828", @"39.25031944", @"120.129025", nil],
                                    [[NSArray alloc] initWithObjects:@"7823", @"39.25037778", @"120.1291083", nil],
                                    [[NSArray alloc] initWithObjects:@"7818", @"39.25044444", @"120.1292111", nil],
                                    [[NSArray alloc] initWithObjects:@"7813", @"39.25051389", @"120.1293167", nil],
                                    [[NSArray alloc] initWithObjects:@"7808", @"39.25056389", @"120.1293972", nil],
                                    [[NSArray alloc] initWithObjects:@"7803", @"39.25061111", @"120.1294667", nil],
                                    [[NSArray alloc] initWithObjects:@"7798", @"39.25065833", @"120.1295389", nil],
                                    [[NSArray alloc] initWithObjects:@"7793", @"39.2507", @"120.1296056", nil],
                                    [[NSArray alloc] initWithObjects:@"7788", @"39.25075556", @"120.1296778", nil],
                                    [[NSArray alloc] initWithObjects:@"7783", @"39.25080556", @"120.1297361", nil],
                                    [[NSArray alloc] initWithObjects:@"7778", @"39.25086111", @"120.1297972", nil],
                                    [[NSArray alloc] initWithObjects:@"7773", @"39.25092222", @"120.1298639", nil],
                                    [[NSArray alloc] initWithObjects:@"7768", @"39.25097778", @"120.129925", nil],
                                    [[NSArray alloc] initWithObjects:@"7763", @"39.25102222", @"120.129975", nil],
                                    [[NSArray alloc] initWithObjects:@"7758", @"39.25105278", @"120.1300083", nil],
                                    [[NSArray alloc] initWithObjects:@"7753", @"39.25108889", @"120.1300472", nil],
                                    [[NSArray alloc] initWithObjects:@"7748", @"39.25112778", @"120.1300944", nil],
                                    [[NSArray alloc] initWithObjects:@"7743", @"39.25117222", @"120.1301444", nil],
                                    [[NSArray alloc] initWithObjects:@"7738", @"39.25118889", @"120.1301917", nil],
                                    [[NSArray alloc] initWithObjects:@"7733", @"39.25120278", @"120.1302389", nil],
                                    [[NSArray alloc] initWithObjects:@"7728", @"39.25121667", @"120.1302778", nil],
                                    [[NSArray alloc] initWithObjects:@"7723", @"39.25123056", @"120.1303167", nil],
                                    [[NSArray alloc] initWithObjects:@"7718", @"39.25124444", @"120.1303556", nil],
                                    [[NSArray alloc] initWithObjects:@"7713", @"39.25125278", @"120.1303889", nil],
                                    [[NSArray alloc] initWithObjects:@"7708", @"39.25126944", @"120.1304333", nil],
                                    [[NSArray alloc] initWithObjects:@"7703", @"39.25128611", @"120.1304806", nil],
                                    [[NSArray alloc] initWithObjects:@"7698", @"39.2513", @"120.1305278", nil],
                                    [[NSArray alloc] initWithObjects:@"7693", @"39.25131389", @"120.1305694", nil],
                                    [[NSArray alloc] initWithObjects:@"7688", @"39.25132778", @"120.1306083", nil],
                                    [[NSArray alloc] initWithObjects:@"7683", @"39.25133889", @"120.1306472", nil],
                                    [[NSArray alloc] initWithObjects:@"7678", @"39.25136111", @"120.1306889", nil],
                                    [[NSArray alloc] initWithObjects:@"7673", @"39.25140556", @"120.1307528", nil],
                                    [[NSArray alloc] initWithObjects:@"7668", @"39.25144444", @"120.1308111", nil],
                                    [[NSArray alloc] initWithObjects:@"7663", @"39.25148333", @"120.1308694", nil],
                                    [[NSArray alloc] initWithObjects:@"7658", @"39.25033611", @"120.1295694", nil],
                                    [[NSArray alloc] initWithObjects:@"7653", @"39.25157778", @"120.1310028", nil],
                                    [[NSArray alloc] initWithObjects:@"7648", @"39.25161667", @"120.1310611", nil],
                                    [[NSArray alloc] initWithObjects:@"7643", @"39.25165", @"120.1311139", nil],
                                    [[NSArray alloc] initWithObjects:@"7638", @"39.25168333", @"120.1311583", nil],
                                    [[NSArray alloc] initWithObjects:@"7633", @"39.25171667", @"120.1312083", nil],
                                    [[NSArray alloc] initWithObjects:@"7628", @"39.25174444", @"120.1312472", nil],
                                    [[NSArray alloc] initWithObjects:@"7623", @"39.25176944", @"120.1312722", nil],
                                    [[NSArray alloc] initWithObjects:@"7618", @"39.25179722", @"120.1312972", nil],
                                    [[NSArray alloc] initWithObjects:@"7613", @"39.25181944", @"120.1313167", nil],
                                    [[NSArray alloc] initWithObjects:@"7608", @"39.25185278", @"120.1313444", nil],
                                    [[NSArray alloc] initWithObjects:@"7603", @"39.25188611", @"120.1313722", nil],
                                    [[NSArray alloc] initWithObjects:@"7598", @"39.25191389", @"120.1313972", nil],
                                    [[NSArray alloc] initWithObjects:@"7593", @"39.25194722", @"120.131425", nil],
                                    [[NSArray alloc] initWithObjects:@"7588", @"39.25198056", @"120.1314556", nil],
                                    [[NSArray alloc] initWithObjects:@"7583", @"39.25200556", @"120.1314778", nil],
                                    [[NSArray alloc] initWithObjects:@"7578", @"39.25203889", @"120.1315083", nil],
                                    [[NSArray alloc] initWithObjects:@"7573", @"39.25208889", @"120.13155", nil],
                                    nil];
  NSArray *googleMap_Siderwinder = [[NSArray alloc] initWithObjects:
                                    [[NSArray alloc] initWithObjects:@"7943", @"39.24862222", @"120.1276167", nil],
                                    [[NSArray alloc] initWithObjects:@"7938", @"39.24867778", @"120.1276639", nil],
                                    [[NSArray alloc] initWithObjects:@"7933", @"39.24873889", @"120.1277167", nil],
                                    [[NSArray alloc] initWithObjects:@"7928", @"39.24882222", @"120.1277889", nil],
                                    [[NSArray alloc] initWithObjects:@"7923", @"39.24890556", @"120.1278611", nil],
                                    [[NSArray alloc] initWithObjects:@"7918", @"39.248975", @"120.1279361", nil],
                                    [[NSArray alloc] initWithObjects:@"7913", @"39.24903611", @"120.1280028", nil],
                                    [[NSArray alloc] initWithObjects:@"7908", @"39.24910278", @"120.128075", nil],
                                    [[NSArray alloc] initWithObjects:@"7903", @"39.24917778", @"120.1281583", nil],
                                    [[NSArray alloc] initWithObjects:@"7898", @"39.24924722", @"120.128225", nil],
                                    [[NSArray alloc] initWithObjects:@"7893", @"39.24930278", @"120.1282556", nil],
                                    [[NSArray alloc] initWithObjects:@"7888", @"39.24936389", @"120.1282889", nil],
                                    [[NSArray alloc] initWithObjects:@"7883", @"39.24945556", @"120.1283361", nil],
                                    [[NSArray alloc] initWithObjects:@"7878", @"39.24953611", @"120.1283806", nil],
                                    [[NSArray alloc] initWithObjects:@"7873", @"39.24961389", @"120.1284222", nil],
                                    [[NSArray alloc] initWithObjects:@"7868", @"39.24974722", @"120.128475", nil],
                                    [[NSArray alloc] initWithObjects:@"7863", @"39.24984444", @"120.1285111", nil],
                                    [[NSArray alloc] initWithObjects:@"7858", @"39.24993333", @"120.1285444", nil],
                                    [[NSArray alloc] initWithObjects:@"7853", @"39.25002778", @"120.1286139", nil],
                                    [[NSArray alloc] initWithObjects:@"7848", @"39.2501", @"120.1287167", nil],
                                    [[NSArray alloc] initWithObjects:@"7843", @"39.25015278", @"120.1287917", nil],
                                    [[NSArray alloc] initWithObjects:@"7838", @"39.25020556", @"120.1288667", nil],
                                    [[NSArray alloc] initWithObjects:@"7833", @"39.25026389", @"120.12895", nil],
                                    [[NSArray alloc] initWithObjects:@"7828", @"39.25031944", @"120.129025", nil],
                                    [[NSArray alloc] initWithObjects:@"7823", @"39.25037778", @"120.1291083", nil],
                                    [[NSArray alloc] initWithObjects:@"7818", @"39.25044444", @"120.1292111", nil],
                                    [[NSArray alloc] initWithObjects:@"7813", @"39.25051389", @"120.1293167", nil],
                                    [[NSArray alloc] initWithObjects:@"7808", @"39.25056389", @"120.1293972", nil],
                                    [[NSArray alloc] initWithObjects:@"7803", @"39.25061111", @"120.1294667", nil],
                                    [[NSArray alloc] initWithObjects:@"7798", @"39.25065833", @"120.1295389", nil],
                                    [[NSArray alloc] initWithObjects:@"7793", @"39.2507", @"120.1296056", nil],
                                    [[NSArray alloc] initWithObjects:@"7788", @"39.25075556", @"120.1296778", nil],
                                    [[NSArray alloc] initWithObjects:@"7783", @"39.25080556", @"120.1297361", nil],
                                    [[NSArray alloc] initWithObjects:@"7778", @"39.25086111", @"120.1297972", nil],
                                    [[NSArray alloc] initWithObjects:@"7773", @"39.25092222", @"120.1298639", nil],
                                    [[NSArray alloc] initWithObjects:@"7768", @"39.25097778", @"120.129925", nil],
                                    [[NSArray alloc] initWithObjects:@"7763", @"39.25102222", @"120.129975", nil],
                                    [[NSArray alloc] initWithObjects:@"7758", @"39.25105278", @"120.1300083", nil],
                                    [[NSArray alloc] initWithObjects:@"7753", @"39.25108889", @"120.1300472", nil],
                                    [[NSArray alloc] initWithObjects:@"7748", @"39.25112778", @"120.1300944", nil],
                                    [[NSArray alloc] initWithObjects:@"7743", @"39.25117222", @"120.1301444", nil],
                                    [[NSArray alloc] initWithObjects:@"7738", @"39.25118889", @"120.1301917", nil],
                                    [[NSArray alloc] initWithObjects:@"7733", @"39.25120278", @"120.1302389", nil],
                                    [[NSArray alloc] initWithObjects:@"7728", @"39.25121667", @"120.1302778", nil],
                                    [[NSArray alloc] initWithObjects:@"7723", @"39.25123056", @"120.1303167", nil],
                                    [[NSArray alloc] initWithObjects:@"7718", @"39.25124444", @"120.1303556", nil],
                                    [[NSArray alloc] initWithObjects:@"7713", @"39.25125278", @"120.1303889", nil],
                                    [[NSArray alloc] initWithObjects:@"7708", @"39.25126944", @"120.1304333", nil],
                                    [[NSArray alloc] initWithObjects:@"7703", @"39.25128611", @"120.1304806", nil],
                                    [[NSArray alloc] initWithObjects:@"7698", @"39.2513", @"120.1305278", nil],
                                    [[NSArray alloc] initWithObjects:@"7693", @"39.25131389", @"120.1305694", nil],
                                    [[NSArray alloc] initWithObjects:@"7688", @"39.25132778", @"120.1306083", nil],
                                    [[NSArray alloc] initWithObjects:@"7683", @"39.25133889", @"120.1306472", nil],
                                    [[NSArray alloc] initWithObjects:@"7678", @"39.25136111", @"120.1306889", nil],
                                    [[NSArray alloc] initWithObjects:@"7673", @"39.25140556", @"120.1307528", nil],
                                    [[NSArray alloc] initWithObjects:@"7668", @"39.25144444", @"120.1308111", nil],
                                    [[NSArray alloc] initWithObjects:@"7663", @"39.25148333", @"120.1308694", nil],
                                    [[NSArray alloc] initWithObjects:@"7658", @"39.25033611", @"120.1295694", nil],
                                    [[NSArray alloc] initWithObjects:@"7653", @"39.25157778", @"120.1310028", nil],
                                    [[NSArray alloc] initWithObjects:@"7648", @"39.25161667", @"120.1310611", nil],
                                    [[NSArray alloc] initWithObjects:@"7643", @"39.25165", @"120.1311139", nil],
                                    [[NSArray alloc] initWithObjects:@"7638", @"39.25168333", @"120.1311583", nil],
                                    [[NSArray alloc] initWithObjects:@"7633", @"39.25171667", @"120.1312083", nil],
                                    [[NSArray alloc] initWithObjects:@"7628", @"39.25174444", @"120.1312472", nil],
                                    [[NSArray alloc] initWithObjects:@"7623", @"39.25176944", @"120.1312722", nil],
                                    [[NSArray alloc] initWithObjects:@"7618", @"39.25179722", @"120.1312972", nil],
                                    [[NSArray alloc] initWithObjects:@"7613", @"39.25181944", @"120.1313167", nil],
                                    [[NSArray alloc] initWithObjects:@"7608", @"39.25185278", @"120.1313444", nil],
                                    [[NSArray alloc] initWithObjects:@"7603", @"39.25188611", @"120.1313722", nil],
                                    [[NSArray alloc] initWithObjects:@"7598", @"39.25191389", @"120.1313972", nil],
                                    [[NSArray alloc] initWithObjects:@"7593", @"39.25194722", @"120.131425", nil],
                                    [[NSArray alloc] initWithObjects:@"7588", @"39.25198056", @"120.1314556", nil],
                                    [[NSArray alloc] initWithObjects:@"7583", @"39.25200556", @"120.1314778", nil],
                                    [[NSArray alloc] initWithObjects:@"7578", @"39.25203889", @"120.1315083", nil],
                                    [[NSArray alloc] initWithObjects:@"7573", @"39.25208889", @"120.13155", nil],
                                    nil];
  NSArray *googleMap_SkidTrail = [[NSArray alloc] initWithObjects:
                                  [[NSArray alloc] initWithObjects:@"8030", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"8025", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"8020", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"8015", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"8010", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"8005", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"8000", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7995", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7990", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7985", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7980", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7975", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7970", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7965", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7960", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7955", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7950", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7945", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7940", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7935", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7930", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7925", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7920", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7915", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7910", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7905", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7900", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7895", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7890", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7885", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7880", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7875", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7870", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7865", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7860", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7855", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7850", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7845", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7840", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7835", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7830", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7825", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7820", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7815", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7810", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7805", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7800", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7795", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7790", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7785", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7780", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7775", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7770", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7765", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7760", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7755", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7750", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7745", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7440", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7735", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7730", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7725", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7720", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7715", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7710", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7705", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7700", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7695", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7690", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7685", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7680", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7675", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7670", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7665", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7660", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7655", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7650", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7645", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7640", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7635", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7630", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7625", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7620", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7615", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7610", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7605", @"39.25998889", @"120.1279056", nil],
                                  [[NSArray alloc] initWithObjects:@"7600", @"39.25998889", @"120.1279056", nil],
                                  nil];
  NSArray *googleMap_TheGulch = [[NSArray alloc] initWithObjects:
                                 [[NSArray alloc] initWithObjects:@"7047", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7042", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7037", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7032", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7027", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7022", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7017", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7012", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7007", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"7002", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6997", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6992", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6987", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6982", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6977", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6972", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6967", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6962", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6957", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6952", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6947", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6942", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6937", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6932", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6927", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6922", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6917", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6912", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6907", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6902", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6897", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6892", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6887", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6882", @"39.25998889", @"120.1279056", nil],
                                 [[NSArray alloc] initWithObjects:@"6877", @"39.25998889", @"120.1279056", nil],
                                 nil];
  NSMutableArray *my_trail_data = [self jerry_init_data];
  NSInteger Lamberjack_elv_first        = [[[googleMap_Lamberjack objectAtIndex:([googleMap_Lamberjack count]-1)]objectAtIndex:0] intValue];
  NSInteger Lamberjack_elv_last         = [[[googleMap_Lamberjack objectAtIndex:0]objectAtIndex:0] intValue];
  NSInteger LowerMainStreet_elv_first   = [[[googleMap_LowerMainStreet objectAtIndex:([googleMap_LowerMainStreet count]-1)]objectAtIndex:0] intValue];
  NSInteger LowerMainStreet_elv_last    = [[[googleMap_LowerMainStreet objectAtIndex:0]objectAtIndex:0] intValue];
  NSInteger MagicMoguls_elv_first       = [[[googleMap_MagicMoguls objectAtIndex:([googleMap_MagicMoguls count]-1)]objectAtIndex:0] intValue];
  NSInteger MagicMoguls_elv_last        = [[[googleMap_MagicMoguls objectAtIndex:0]objectAtIndex:0] intValue];
  NSInteger Siderwinder_elv_first       = [[[googleMap_Siderwinder objectAtIndex:([googleMap_Siderwinder count]-1)]objectAtIndex:0] intValue];
  NSInteger Siderwinder_elv_last        = [[[googleMap_Siderwinder objectAtIndex:0]objectAtIndex:0] intValue];
  NSInteger SkidTrail_elv_first         = [[[googleMap_SkidTrail objectAtIndex:([googleMap_SkidTrail count]-1)]objectAtIndex:0] intValue];
  NSInteger SkidTrail_elv_last          = [[[googleMap_SkidTrail objectAtIndex:0]objectAtIndex:0] intValue];
  NSInteger TheGulch_elv_first          = [[[googleMap_TheGulch objectAtIndex:([googleMap_TheGulch count]-1)]objectAtIndex:0] intValue];
  NSInteger TheGulch_elv_last           = [[[googleMap_TheGulch objectAtIndex:0]objectAtIndex:0] intValue];
  int roundStep = 5;
  int up_counter = 0;
  int down_counter = 0;
  int detect_limit = 10;
  int going_up = 1; //always assume going up. it's ok to take 3 data less when it's oing down but not ok to take 3 extra data when going up
  NSInteger previous_user_elv = 0;
  
  NSMutableArray  * trail_match_result = [NSMutableArray new];
  /*********************************JERRY TRAIL CALCULATION START ******************************/
//  int user_array_last_index = [my_trail_data count]-1 ;
//  for (int i = 0; i < user_array_last_index; i++) {
//    NSInteger user_elv = [self get_elv:my_trail_data atIndex:i]*3;
//    
//    
//    
//    
//    if(user_elv > previous_user_elv){
//      up_counter++;
//    }else if(user_elv < previous_user_elv){
//      down_counter++;
//    }
//    if(going_up){
//      if(down_counter>= detect_limit){
//        going_up=0;
//        up_counter=0;
//      }
//    }else{ //going down
//      if(up_counter >= detect_limit){
//        going_up = 1;
//        down_counter = 0;
//      }
//    }
//    previous_user_elv = user_elv;
//    NSLog(@"up_counter is %d", up_counter);
//    NSLog(@"down_counter is %d", down_counter);
//    NSLog(@"current going up is %d", going_up);
//    if(going_up){
//      NSLog(@"wasting data %ld",(long)user_elv);
//    }else{
//        float Lamberjack_elv_diff = 0;
//        NSLog(@"user elv is %ld", (long)user_elv);
//        NSLog(@"Lamberjack elv is %d - %d", Lamberjack_elv_first, Lamberjack_elv_last);
//        if(user_elv >= Lamberjack_elv_first && user_elv <= Lamberjack_elv_last){
//          NSLog(@"looking Lamberjack");
//          int at_Lamberjack_index = [googleMap_Lamberjack count]-1- (user_elv-Lamberjack_elv_first)/roundStep;
//          Lamberjack_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_Lamberjack :at_Lamberjack_index];
//          //NSLog(@"Lamberjack diff %d", Lamberjack_elv_diff);
//        }else{
//          Lamberjack_elv_diff = -1;
//        }
//        NSLog(@"LowerMainStreet elv is %d - %d", LowerMainStreet_elv_first, LowerMainStreet_elv_last);
//        float LowerMainStreet_elv_diff = 0;
//        if(user_elv >= LowerMainStreet_elv_first && user_elv <= LowerMainStreet_elv_last){
//          NSLog(@"looking LowerMain");
//          NSLog(@"LowerMainStreet total count is %d, steps is %d", [googleMap_LowerMainStreet count],(user_elv-LowerMainStreet_elv_first)/roundStep);
//          int at_LowerMainStreet_index = [googleMap_LowerMainStreet count]-1- (user_elv-LowerMainStreet_elv_first)/roundStep;
//          LowerMainStreet_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_LowerMainStreet :at_LowerMainStreet_index];
//        }else{
//          LowerMainStreet_elv_diff = -1;
//        }
//        NSLog(@"MagicMoguls elv is %d - %d", MagicMoguls_elv_first, MagicMoguls_elv_last);
//        float MagicMoguls_elv_diff = 0;
//        if(user_elv >= MagicMoguls_elv_first && user_elv <= MagicMoguls_elv_last){
//          NSLog(@"looking Magic");
//          int at_MagicMoguls_index = [googleMap_MagicMoguls count]-1- (user_elv-MagicMoguls_elv_first)/roundStep;
//          MagicMoguls_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_MagicMoguls :at_MagicMoguls_index];
//        }else{
//          MagicMoguls_elv_diff = -1;
//        }
//        NSLog(@"Siderwinder elv is %d - %d", Siderwinder_elv_first, Siderwinder_elv_last);
//        float Siderwinder_elv_diff = 0;
//        if(user_elv >= Siderwinder_elv_first && user_elv <= Siderwinder_elv_last){
//          NSLog(@"looking Siderwinder");
//          int at_Siderwinder_index = [googleMap_Siderwinder count]-1- (user_elv-Siderwinder_elv_first)/roundStep;
//          Siderwinder_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_Siderwinder :at_Siderwinder_index];
//        }else{
//          Siderwinder_elv_diff = -1;
//        }
//        NSLog(@"SkidTrail elv is %d - %d", SkidTrail_elv_first, SkidTrail_elv_last);
//        float SkidTrail_elv_diff = 0;
//        if(user_elv >= SkidTrail_elv_first && user_elv <= SkidTrail_elv_last){
//          NSLog(@"looking SkidTrail");
//          int at_SkidTrail_index = [googleMap_SkidTrail count]-1- (user_elv-SkidTrail_elv_first)/roundStep;
//          SkidTrail_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_SkidTrail :at_SkidTrail_index];
//        }else{
//          SkidTrail_elv_diff = -1;
//        }
//        NSLog(@"TheGulch elv is %d - %d", TheGulch_elv_first, TheGulch_elv_last);
//        float TheGulch_elv_diff = 0;
//        if(user_elv >= TheGulch_elv_first && user_elv <= TheGulch_elv_last){
//          NSLog(@"looking Gulch");
//          int at_TheGulch_index = [googleMap_TheGulch count]-1- (user_elv-TheGulch_elv_first)/roundStep;
//          TheGulch_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_TheGulch :at_TheGulch_index];
//        }else{
//          TheGulch_elv_diff = -1;
//        }
//        NSArray  *trail_diff = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:Lamberjack_elv_diff], [NSNumber numberWithInt:LowerMainStreet_elv_diff], [NSNumber numberWithInt:MagicMoguls_elv_diff], [NSNumber numberWithInt:Siderwinder_elv_diff], [NSNumber numberWithInt:SkidTrail_elv_diff], [NSNumber numberWithInt:TheGulch_elv_diff], nil];
//        float min = 999999999.0;
//        NSInteger match_trail = -1;
//        for (int j = 0; j < [trail_diff count]; j++) {
//            NSLog(@"diff is %f",[[trail_diff objectAtIndex:j] floatValue] );
//          if([[trail_diff objectAtIndex:j] integerValue] != -1 && [[trail_diff objectAtIndex:j] floatValue]<min){
//            NSLog(@"==filtering @index %d", j);
//            min = [[trail_diff objectAtIndex:j] floatValue];
//            NSLog(@"min updated as %f", min);
//            match_trail  = j;
//          }
//        }
//        [trail_match_result addObject:[NSNumber numberWithInt:match_trail]];
//    }
//  }
//  for (int tom = 0; tom < [trail_match_result count]; tom++){
//    NSLog(@"match -->%d %d", tom, [[trail_match_result objectAtIndex:tom] integerValue]);
//  }
  /*********************************JERRY TRAIL CALCULATION END ******************************/


  NSArray *lumberJack = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(266.5, 189)],   //LUMBERJACK
                         [NSValue valueWithCGPoint:CGPointMake(262.5, 197)],
                         [NSValue valueWithCGPoint:CGPointMake(259.5, 204)],
                         [NSValue valueWithCGPoint:CGPointMake(255.5, 214)],    //rows should be 5+3x lanes
                         [NSValue valueWithCGPoint:CGPointMake(252.5, 222)],
                         [NSValue valueWithCGPoint:CGPointMake(250.5, 229)],
                         [NSValue valueWithCGPoint:CGPointMake(247.5, 239)],
                         [NSValue valueWithCGPoint:CGPointMake(242.5, 247)],
                         [NSValue valueWithCGPoint:CGPointMake(232.5, 254)],
                         [NSValue valueWithCGPoint:CGPointMake(225.5, 259)],
                         [NSValue valueWithCGPoint:CGPointMake(221.5, 265)],
                         [NSValue valueWithCGPoint:CGPointMake(217.5, 273)],
                         [NSValue valueWithCGPoint:CGPointMake(213.5, 280)],
                         [NSValue valueWithCGPoint:CGPointMake(211.5, 288)],
                         [NSValue valueWithCGPoint:CGPointMake(207.5, 299)], nil];
//  
//  
  NSArray *lowerMainStreet = [[NSArray alloc] initWithObjects:
                              [NSValue valueWithCGPoint:CGPointMake(207.5, 300)],  //LOWER MAIN STREET
                              [NSValue valueWithCGPoint:CGPointMake(203.5, 305)],
                              [NSValue valueWithCGPoint:CGPointMake(198.5, 310)],
                              [NSValue valueWithCGPoint:CGPointMake(193.5, 317)],
                              [NSValue valueWithCGPoint:CGPointMake(189.5, 323)],
                              [NSValue valueWithCGPoint:CGPointMake(183.5, 331)],
                              [NSValue valueWithCGPoint:CGPointMake(178.5, 337)],
                              [NSValue valueWithCGPoint:CGPointMake(172.5, 343)], nil];
  NSArray *theGulch = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(214.5, 317)],   //THE GULCH
                       [NSValue valueWithCGPoint:CGPointMake(212.5, 321)],
                      [NSValue valueWithCGPoint:CGPointMake(210.5, 324)],
                      [NSValue valueWithCGPoint:CGPointMake(207.5, 328)],
                     [NSValue valueWithCGPoint:CGPointMake(204.5, 330)],
                      [NSValue valueWithCGPoint:CGPointMake(201.5, 335)],
                       [NSValue valueWithCGPoint:CGPointMake(197.5, 338)],
                       [NSValue valueWithCGPoint:CGPointMake(193.5, 340)],
                      [NSValue valueWithCGPoint:CGPointMake(189.5, 343)],
                       [NSValue valueWithCGPoint:CGPointMake(185.5, 347)],
                       [NSValue valueWithCGPoint:CGPointMake(193.5, 340.5)],
                       [NSValue valueWithCGPoint:CGPointMake(190.5, 342.5)],
                       [NSValue valueWithCGPoint:CGPointMake(186.5, 344.5)],
                       [NSValue valueWithCGPoint:CGPointMake(182.5, 350.5)],nil];
  
    NSArray *Skidtrail = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(220.5, 158.5)],
                         [NSValue valueWithCGPoint:CGPointMake(228.5, 162.5)],
                         [NSValue valueWithCGPoint:CGPointMake(238.5, 169.5)],
                         [NSValue valueWithCGPoint:CGPointMake(245.5, 174.5)],
                         [NSValue valueWithCGPoint:CGPointMake(253.5, 181.5)],
                         [NSValue valueWithCGPoint:CGPointMake(262.5, 186.5)],
                         [NSValue valueWithCGPoint:CGPointMake(168.5, 191.5)],nil];

  NSArray *Magicmoglus = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(212, 164)],
                       [NSValue valueWithCGPoint:CGPointMake(217, 167)],
                       [NSValue valueWithCGPoint:CGPointMake(221, 173)],
                       [NSValue valueWithCGPoint:CGPointMake(225, 177)],
                       [NSValue valueWithCGPoint:CGPointMake(230, 182)],
                       [NSValue valueWithCGPoint:CGPointMake(236, 187)],
                       [NSValue valueWithCGPoint:CGPointMake(241, 190)],
                       [NSValue valueWithCGPoint:CGPointMake(245, 194)],
                       [NSValue valueWithCGPoint:CGPointMake(249, 198)],
                       [NSValue valueWithCGPoint:CGPointMake(254, 203)],
                       [NSValue valueWithCGPoint:CGPointMake(259, 208)],nil];

  NSArray *Sidewinder = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(190.5, 161.5)],
                       [NSValue valueWithCGPoint:CGPointMake(194.5, 168.5)],
                       [NSValue valueWithCGPoint:CGPointMake(196.5, 174.5)],
                       [NSValue valueWithCGPoint:CGPointMake(200.5, 181.5)],
                       [NSValue valueWithCGPoint:CGPointMake(203.5, 188.5)],
                       [NSValue valueWithCGPoint:CGPointMake(206.5, 197.5)],
                       [NSValue valueWithCGPoint:CGPointMake(210.5, 210.5)],
                       [NSValue valueWithCGPoint:CGPointMake(210.5, 218.5)],
                       [NSValue valueWithCGPoint:CGPointMake(210.5, 228.5)],
                       [NSValue valueWithCGPoint:CGPointMake(212.5, 244.5)],
                       [NSValue valueWithCGPoint:CGPointMake(214.5, 253.5)],
                       [NSValue valueWithCGPoint:CGPointMake(213.5, 264.5)],nil];

  
  NSArray *Forerunner = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(218, 180)],
                         [NSValue valueWithCGPoint:CGPointMake(218, 185)],
                         [NSValue valueWithCGPoint:CGPointMake(216, 192)],
                         [NSValue valueWithCGPoint:CGPointMake(217, 198)],
                         [NSValue valueWithCGPoint:CGPointMake(218, 204)],
                         [NSValue valueWithCGPoint:CGPointMake(215.5, 212)],
                         [NSValue valueWithCGPoint:CGPointMake(214.5, 218)],
                         [NSValue valueWithCGPoint:CGPointMake(214.5, 228)],
                         [NSValue valueWithCGPoint:CGPointMake(214.5, 237)],nil];
  
  NSArray *Moonshine = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(179.5, 171.5)],
                         [NSValue valueWithCGPoint:CGPointMake(182.5, 178.5)],
                         [NSValue valueWithCGPoint:CGPointMake(186.5, 185.5)],
                         [NSValue valueWithCGPoint:CGPointMake(187.5, 195.5)],
                         [NSValue valueWithCGPoint:CGPointMake(190.5, 206.5)],
                         [NSValue valueWithCGPoint:CGPointMake(192.5, 216.5)],
                         [NSValue valueWithCGPoint:CGPointMake(197.5, 238.5)],
                         [NSValue valueWithCGPoint:CGPointMake(199.5, 246.5)],
                         [NSValue valueWithCGPoint:CGPointMake(201.5, 254.5)],
                         [NSValue valueWithCGPoint:CGPointMake(206.5, 263.5)],
                         [NSValue valueWithCGPoint:CGPointMake(213.5, 272.5)],nil];
  
  NSArray *Pinball = [[NSArray alloc] initWithObjects:
                        [NSValue valueWithCGPoint:CGPointMake(172, 186)],
                        [NSValue valueWithCGPoint:CGPointMake(176, 194)],
                        [NSValue valueWithCGPoint:CGPointMake(176, 201)],
                        [NSValue valueWithCGPoint:CGPointMake(175, 208)],
                        [NSValue valueWithCGPoint:CGPointMake(179, 216.5)],
                        [NSValue valueWithCGPoint:CGPointMake(179, 224.5)],
                        [NSValue valueWithCGPoint:CGPointMake(180, 234.5)],
                        [NSValue valueWithCGPoint:CGPointMake(179, 242)],
                        [NSValue valueWithCGPoint:CGPointMake(179, 249.5)],
                        [NSValue valueWithCGPoint:CGPointMake(183, 255.5)],
                        [NSValue valueWithCGPoint:CGPointMake(189, 266.5)],
                        [NSValue valueWithCGPoint:CGPointMake(191, 275.5)],
                        [NSValue valueWithCGPoint:CGPointMake(192, 284.5)],
                        [NSValue valueWithCGPoint:CGPointMake(193, 294.5)],
                        [NSValue valueWithCGPoint:CGPointMake(196, 308.5)],nil];
  
  NSArray *Thestairs = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(167.5, 190.5)],
                         [NSValue valueWithCGPoint:CGPointMake(166.5, 197.5)],
                         [NSValue valueWithCGPoint:CGPointMake(165.5, 210.5)],
                         [NSValue valueWithCGPoint:CGPointMake(164.5, 220.5)],
                         [NSValue valueWithCGPoint:CGPointMake(164.5, 231.5)],
                         [NSValue valueWithCGPoint:CGPointMake(163.5, 244.5)],
                         [NSValue valueWithCGPoint:CGPointMake(165.5, 254)],
                         [NSValue valueWithCGPoint:CGPointMake(170.5, 261)],nil];
  
  NSArray *Pipeline = [[NSArray alloc] initWithObjects:
                        [NSValue valueWithCGPoint:CGPointMake(172.5, 263.5)],
                        [NSValue valueWithCGPoint:CGPointMake(177.5, 271.5)],
                        [NSValue valueWithCGPoint:CGPointMake(178.5, 279.5)],
                        [NSValue valueWithCGPoint:CGPointMake(179.5, 292.5)],
                        [NSValue valueWithCGPoint:CGPointMake(176.5, 299.5)],nil];
  
  NSArray *Dropoff = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(149, 182)],
                      [NSValue valueWithCGPoint:CGPointMake(148, 190)],
                      [NSValue valueWithCGPoint:CGPointMake(147, 200)],
                      [NSValue valueWithCGPoint:CGPointMake(144, 211)],
                      [NSValue valueWithCGPoint:CGPointMake(142, 221)],
                      [NSValue valueWithCGPoint:CGPointMake(141, 232)],
                      [NSValue valueWithCGPoint:CGPointMake(144, 241)],
                      [NSValue valueWithCGPoint:CGPointMake(153, 249)],
                      [NSValue valueWithCGPoint:CGPointMake(154, 259)],
                      [NSValue valueWithCGPoint:CGPointMake(155, 268)],
                      [NSValue valueWithCGPoint:CGPointMake(160, 279)],
                      [NSValue valueWithCGPoint:CGPointMake(168, 292)],
                      [NSValue valueWithCGPoint:CGPointMake(173, 301)],nil];
  
  NSArray *Woodchuck = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(123.5, 249.5)],
                      [NSValue valueWithCGPoint:CGPointMake(128.5, 252.5)],
                      [NSValue valueWithCGPoint:CGPointMake(132.5, 257.5)],
                      [NSValue valueWithCGPoint:CGPointMake(128.5, 252.5)],
                      [NSValue valueWithCGPoint:CGPointMake(132.5, 257.5)],
                      [NSValue valueWithCGPoint:CGPointMake(136.5, 261.5)],
                      [NSValue valueWithCGPoint:CGPointMake(142.5, 267.5)],
                      [NSValue valueWithCGPoint:CGPointMake(147.5, 272.5)],
                      [NSValue valueWithCGPoint:CGPointMake(154.5, 275.5)],
                      [NSValue valueWithCGPoint:CGPointMake(160.5, 281.5)],nil];
  
  NSArray *Loggersloop = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(142, 185)],
                      [NSValue valueWithCGPoint:CGPointMake(136.5, 193)],
                      [NSValue valueWithCGPoint:CGPointMake(130, 201)],
                      [NSValue valueWithCGPoint:CGPointMake(124, 207)],
                      [NSValue valueWithCGPoint:CGPointMake(121.5, 215)],
                      [NSValue valueWithCGPoint:CGPointMake(122, 223)],
                      [NSValue valueWithCGPoint:CGPointMake(122, 232)],
                      [NSValue valueWithCGPoint:CGPointMake(122, 240)],
                      [NSValue valueWithCGPoint:CGPointMake(117, 248)],
                      [NSValue valueWithCGPoint:CGPointMake(109, 255)],
                      [NSValue valueWithCGPoint:CGPointMake(102, 261)],
                      [NSValue valueWithCGPoint:CGPointMake(92, 265)],
                      [NSValue valueWithCGPoint:CGPointMake(86.5, 268)],
                      [NSValue valueWithCGPoint:CGPointMake(80, 271)],
                      [NSValue valueWithCGPoint:CGPointMake(80, 279)],
                      [NSValue valueWithCGPoint:CGPointMake(81.5, 288)],
                      [NSValue valueWithCGPoint:CGPointMake(81.5, 293.5)],
                      [NSValue valueWithCGPoint:CGPointMake(85.5, 297.5)],
                      [NSValue valueWithCGPoint:CGPointMake(91.5, 301.5)],
                      [NSValue valueWithCGPoint:CGPointMake(98.5, 305.5)],
                      [NSValue valueWithCGPoint:CGPointMake(107.5, 309.5)],
                      [NSValue valueWithCGPoint:CGPointMake(116.5, 315.5)],
                      [NSValue valueWithCGPoint:CGPointMake(125.5, 319.5)],
                      [NSValue valueWithCGPoint:CGPointMake(133.5, 323.5)],
                      [NSValue valueWithCGPoint:CGPointMake(143.5, 325.5)],
                      [NSValue valueWithCGPoint:CGPointMake(154.5, 330.5)],nil];
  
  NSArray *Catsface = [[NSArray alloc] initWithObjects: //Cat's face
                        [NSValue valueWithCGPoint:CGPointMake(96.5, 271)],
                        [NSValue valueWithCGPoint:CGPointMake(93.5, 275)],
                        [NSValue valueWithCGPoint:CGPointMake(89.5, 280)],
                        [NSValue valueWithCGPoint:CGPointMake(87.5, 286)],
                        [NSValue valueWithCGPoint:CGPointMake(88.5, 291)],
                        [NSValue valueWithCGPoint:CGPointMake(88.5, 294)],nil];
  
  NSArray *Thewoods = [[NSArray alloc] initWithObjects:
                          [NSValue valueWithCGPoint:CGPointMake(57, 349)],
                          [NSValue valueWithCGPoint:CGPointMake(52, 356)],
                          [NSValue valueWithCGPoint:CGPointMake(48, 366)],
                          [NSValue valueWithCGPoint:CGPointMake(45, 372)],
                          [NSValue valueWithCGPoint:CGPointMake(43, 377)],
                          [NSValue valueWithCGPoint:CGPointMake(46, 385)],
                          [NSValue valueWithCGPoint:CGPointMake(50, 388)],
                          [NSValue valueWithCGPoint:CGPointMake(53, 391)],
                          [NSValue valueWithCGPoint:CGPointMake(52, 398)],
                          [NSValue valueWithCGPoint:CGPointMake(49, 403)],
                          [NSValue valueWithCGPoint:CGPointMake(48, 406)],
                          [NSValue valueWithCGPoint:CGPointMake(47, 413)],
                          [NSValue valueWithCGPoint:CGPointMake(45, 417)],
                          [NSValue valueWithCGPoint:CGPointMake(43, 423)],
                          [NSValue valueWithCGPoint:CGPointMake(47, 432)],
                          [NSValue valueWithCGPoint:CGPointMake(50, 438)],
                          [NSValue valueWithCGPoint:CGPointMake(55, 443)],
                          [NSValue valueWithCGPoint:CGPointMake(60, 448)],
                          [NSValue valueWithCGPoint:CGPointMake(65, 453)],
                          [NSValue valueWithCGPoint:CGPointMake(72, 464)],nil];
  NSArray *Condorun = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(90, 420)],
                       [NSValue valueWithCGPoint:CGPointMake(84, 429)],
                       [NSValue valueWithCGPoint:CGPointMake(81, 437)],
                       [NSValue valueWithCGPoint:CGPointMake(77, 442)],
                       [NSValue valueWithCGPoint:CGPointMake(73, 448)],
                       [NSValue valueWithCGPoint:CGPointMake(69, 454)],
                       [NSValue valueWithCGPoint:CGPointMake(67, 459)],nil];
  NSArray *Villagerun = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(130, 383.5)],
                       [NSValue valueWithCGPoint:CGPointMake(125, 385.5)],
                       [NSValue valueWithCGPoint:CGPointMake(121, 388.5)],
                       [NSValue valueWithCGPoint:CGPointMake(113, 392.5)],
                       [NSValue valueWithCGPoint:CGPointMake(104, 397)],
                       [NSValue valueWithCGPoint:CGPointMake(99, 402.5)],
                       [NSValue valueWithCGPoint:CGPointMake(91, 409.5)],
                       [NSValue valueWithCGPoint:CGPointMake(87, 412)],
                       [NSValue valueWithCGPoint:CGPointMake(84.5, 415.5)],nil];
  NSArray *Coyotefork = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(150, 417.5)],
                         [NSValue valueWithCGPoint:CGPointMake(144, 417.5)],
                         [NSValue valueWithCGPoint:CGPointMake(138, 419.5)],
                         [NSValue valueWithCGPoint:CGPointMake(132, 423.5)],
                         [NSValue valueWithCGPoint:CGPointMake(125, 429.5)],
                         [NSValue valueWithCGPoint:CGPointMake(120, 433.5)],
                         [NSValue valueWithCGPoint:CGPointMake(115, 438.5)],
                         [NSValue valueWithCGPoint:CGPointMake(113, 440.5)],
                         [NSValue valueWithCGPoint:CGPointMake(115, 445.5)],
                         [NSValue valueWithCGPoint:CGPointMake(117, 453.5)],nil];
  NSArray *Homerun = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(163, 424)],
                       [NSValue valueWithCGPoint:CGPointMake(168.5, 417.5)],
                       [NSValue valueWithCGPoint:CGPointMake(176.5, 414.5)],
                       [NSValue valueWithCGPoint:CGPointMake(184.5, 408.5)],
                       [NSValue valueWithCGPoint:CGPointMake(192.5, 405.5)],
                       [NSValue valueWithCGPoint:CGPointMake(201.5, 400.5)],
                       [NSValue valueWithCGPoint:CGPointMake(208.5, 395.5)],
                       [NSValue valueWithCGPoint:CGPointMake(217.5, 390.5)],
                       [NSValue valueWithCGPoint:CGPointMake(225.5, 386.5)],
                       [NSValue valueWithCGPoint:CGPointMake(230.5, 377.5)],
                       [NSValue valueWithCGPoint:CGPointMake(233.5, 369.5)],
                       [NSValue valueWithCGPoint:CGPointMake(242.5, 367.5)],
                       [NSValue valueWithCGPoint:CGPointMake(251.5, 362.5)],
                       [NSValue valueWithCGPoint:CGPointMake(256.5, 352.5)],
                       [NSValue valueWithCGPoint:CGPointMake(260.5, 341.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 335.5)],
                       [NSValue valueWithCGPoint:CGPointMake(276.5, 323.5)],
                       [NSValue valueWithCGPoint:CGPointMake(281.5, 322.5)],
                       [NSValue valueWithCGPoint:CGPointMake(288.5, 318.5)],
                       [NSValue valueWithCGPoint:CGPointMake(295.5, 315.5)],nil];
  NSArray *Theglades = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(229, 416.5)],
                       [NSValue valueWithCGPoint:CGPointMake(228, 421.5)],
                       [NSValue valueWithCGPoint:CGPointMake(230, 426.5)],
                       [NSValue valueWithCGPoint:CGPointMake(233, 430.5)],
                       [NSValue valueWithCGPoint:CGPointMake(236, 434.5)],
                       [NSValue valueWithCGPoint:CGPointMake(241, 437.5)],
                       [NSValue valueWithCGPoint:CGPointMake(244, 441.5)],
                       [NSValue valueWithCGPoint:CGPointMake(249, 447.5)],nil];
  
  NSArray *Timberline = [[NSArray alloc] initWithObjects:
                        [NSValue valueWithCGPoint:CGPointMake(243.5, 427.5)],
                        [NSValue valueWithCGPoint:CGPointMake(241.5, 420)],
                        [NSValue valueWithCGPoint:CGPointMake(240.5, 416.5)],
                        [NSValue valueWithCGPoint:CGPointMake(235.5, 409.5)],
                        [NSValue valueWithCGPoint:CGPointMake(232.5, 405.5)],
                        [NSValue valueWithCGPoint:CGPointMake(229.5, 403.5)],
                        [NSValue valueWithCGPoint:CGPointMake(227.5, 378.5)],
                        [NSValue valueWithCGPoint:CGPointMake(225.5, 370.5)],
                        [NSValue valueWithCGPoint:CGPointMake(225.5, 365.5)],nil];
  NSArray *Woodcutter = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(187, 357)],
                         [NSValue valueWithCGPoint:CGPointMake(191, 355.5)],
                         [NSValue valueWithCGPoint:CGPointMake(195, 355.5)],
                         [NSValue valueWithCGPoint:CGPointMake(201, 354.5)],
                         [NSValue valueWithCGPoint:CGPointMake(206, 352.5)],
                         [NSValue valueWithCGPoint:CGPointMake(211, 351.5)],
                         [NSValue valueWithCGPoint:CGPointMake(215, 349.5)],
                         [NSValue valueWithCGPoint:CGPointMake(221, 348.5)],
                         [NSValue valueWithCGPoint:CGPointMake(224, 348.5)],nil];
  
  NSArray *Easystreet = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(212.5, 336.5)],
                         [NSValue valueWithCGPoint:CGPointMake(219.5, 340.5)],
                         [NSValue valueWithCGPoint:CGPointMake(224.5, 346.5)],
                         [NSValue valueWithCGPoint:CGPointMake(227.5, 353.5)],
                         [NSValue valueWithCGPoint:CGPointMake(228.5, 356.5)],
                         [NSValue valueWithCGPoint:CGPointMake(229.5, 362.5)],nil];
  NSArray *Hornetsnest = [[NSArray alloc] initWithObjects:  //    Black Hornet's nest
                         [NSValue valueWithCGPoint:CGPointMake(122.5, 270)],
                         [NSValue valueWithCGPoint:CGPointMake(125.5, 275)],
                         [NSValue valueWithCGPoint:CGPointMake(127.5, 285)],
                         [NSValue valueWithCGPoint:CGPointMake(129.5, 293)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 298)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 304)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 310)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 310)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 320)],nil];
  NSArray *Surprise = [[NSArray alloc] initWithObjects:  //    Black Hornet's nest
                          [NSValue valueWithCGPoint:CGPointMake(136.5, 281.5)],
                          [NSValue valueWithCGPoint:CGPointMake(138.5, 286.5)],
                          [NSValue valueWithCGPoint:CGPointMake(139.5, 291.5)],
                          [NSValue valueWithCGPoint:CGPointMake(139.5, 297.5)],
                          [NSValue valueWithCGPoint:CGPointMake(141.4, 304.5)],
                          [NSValue valueWithCGPoint:CGPointMake(143.5, 314.5)],
                          [NSValue valueWithCGPoint:CGPointMake(145.5, 317.5)],
                          [NSValue valueWithCGPoint:CGPointMake(147.5, 320.5)],nil];
  NSArray *Lowerlionswy = [[NSArray alloc] initWithObjects:  //    Green
                       [NSValue valueWithCGPoint:CGPointMake(253.5, 356)],
                       [NSValue valueWithCGPoint:CGPointMake(249.5, 359)],
                       [NSValue valueWithCGPoint:CGPointMake(243.5, 363)],
                       [NSValue valueWithCGPoint:CGPointMake(237.5, 365)],
                       [NSValue valueWithCGPoint:CGPointMake(232.5, 365)],
                       [NSValue valueWithCGPoint:CGPointMake(225.5, 367)],
                       [NSValue valueWithCGPoint:CGPointMake(219.5, 367)],
                       [NSValue valueWithCGPoint:CGPointMake(214.5, 365)],nil];
  NSArray *Upperlionswy = [[NSArray alloc] initWithObjects:  //    Blue
                           [NSValue valueWithCGPoint:CGPointMake(260.5, 322.5)],
                           [NSValue valueWithCGPoint:CGPointMake(259.5, 328.5)],
                           [NSValue valueWithCGPoint:CGPointMake(257.5, 334.5)],
                           [NSValue valueWithCGPoint:CGPointMake(257.5, 339.5)],
                           [NSValue valueWithCGPoint:CGPointMake(256.6, 343.5)],
                           [NSValue valueWithCGPoint:CGPointMake(254.5, 348.5)],
                           [NSValue valueWithCGPoint:CGPointMake(253.5, 351.5)],
                           [NSValue valueWithCGPoint:CGPointMake(251.5, 355.5)],
                           [NSValue valueWithCGPoint:CGPointMake(249.5, 358.5)],nil];
  NSArray *Eastridge = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(356.5, 57)],
                      [NSValue valueWithCGPoint:CGPointMake(347.5, 59)],
                      [NSValue valueWithCGPoint:CGPointMake(339.5, 62)],
                      [NSValue valueWithCGPoint:CGPointMake(330.5, 63)],
                      [NSValue valueWithCGPoint:CGPointMake(315, 68)],
                      [NSValue valueWithCGPoint:CGPointMake(304, 71)],
                      [NSValue valueWithCGPoint:CGPointMake(294, 76)],
                      [NSValue valueWithCGPoint:CGPointMake(284, 80)],
                      [NSValue valueWithCGPoint:CGPointMake(270, 83)],
                      [NSValue valueWithCGPoint:CGPointMake(263, 88)],
                      [NSValue valueWithCGPoint:CGPointMake(251, 91)],
                      [NSValue valueWithCGPoint:CGPointMake(236, 94)],
                      [NSValue valueWithCGPoint:CGPointMake(206, 103)],
                      [NSValue valueWithCGPoint:CGPointMake(197, 107)],
                      [NSValue valueWithCGPoint:CGPointMake(188, 111)],
                      [NSValue valueWithCGPoint:CGPointMake(180, 117)],
                      [NSValue valueWithCGPoint:CGPointMake(177, 123)],
                      [NSValue valueWithCGPoint:CGPointMake(177, 128)],nil];
  
  NSArray *Delight = [[NSArray alloc] initWithObjects:  //    Black
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 123.5)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 126)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 130)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 130.5)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 140)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 143)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 149)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 154.5)],nil];
  NSArray *Dutchman = [[NSArray alloc] initWithObjects:  //    Black
                      [NSValue valueWithCGPoint:CGPointMake(207.5, 113.5)],
                      [NSValue valueWithCGPoint:CGPointMake(208.5, 118.5)],
                      [NSValue valueWithCGPoint:CGPointMake(209.5, 125.5)],
                      [NSValue valueWithCGPoint:CGPointMake(210.5, 128.5)],
                      [NSValue valueWithCGPoint:CGPointMake(211.5, 132.5)],
                      [NSValue valueWithCGPoint:CGPointMake(211.5, 136.5)],
                      [NSValue valueWithCGPoint:CGPointMake(213.5, 139.5)],
                      [NSValue valueWithCGPoint:CGPointMake(214.5, 146.5)],
                      [NSValue valueWithCGPoint:CGPointMake(216.5, 149.5)],nil];
  NSArray *Thechute = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(236, 114.5)],
                       [NSValue valueWithCGPoint:CGPointMake(238, 117.5)],
                       [NSValue valueWithCGPoint:CGPointMake(241, 124.5)],
                       [NSValue valueWithCGPoint:CGPointMake(242, 130.5)],
                       [NSValue valueWithCGPoint:CGPointMake(243, 136.5)],
                       [NSValue valueWithCGPoint:CGPointMake(242, 141.5)],
                       [NSValue valueWithCGPoint:CGPointMake(242, 145.5)],
                       [NSValue valueWithCGPoint:CGPointMake(243, 150.5)],nil];
  NSArray *Toninis = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(265.5, 106.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 116.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 124.5)],
                       [NSValue valueWithCGPoint:CGPointMake(266.5, 129.5)],
                       [NSValue valueWithCGPoint:CGPointMake(266.5, 136.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 141.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 146.5)],nil];
  NSArray *Crosscut = [[NSArray alloc] initWithObjects:  //    Black
                      [NSValue valueWithCGPoint:CGPointMake(294, 95.5)],
                      [NSValue valueWithCGPoint:CGPointMake(295, 101.5)],
                      [NSValue valueWithCGPoint:CGPointMake(295, 105.5)],
                      [NSValue valueWithCGPoint:CGPointMake(295, 114.5)],
                      [NSValue valueWithCGPoint:CGPointMake(294, 118.5)],
                      [NSValue valueWithCGPoint:CGPointMake(292, 122.5)],
                      [NSValue valueWithCGPoint:CGPointMake(289, 127.5)],
                      [NSValue valueWithCGPoint:CGPointMake(288, 133.5)],nil];
  NSArray *Rendezvousglade = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(296.5, 83)],
                       [NSValue valueWithCGPoint:CGPointMake(298.5, 87)],
                       [NSValue valueWithCGPoint:CGPointMake(299.5, 90)],
                       [NSValue valueWithCGPoint:CGPointMake(300.5, 93)],
                       [NSValue valueWithCGPoint:CGPointMake(302.5, 100)],
                       [NSValue valueWithCGPoint:CGPointMake(301.5, 105.5)],
                       [NSValue valueWithCGPoint:CGPointMake(301.5, 110.5)],
                       [NSValue valueWithCGPoint:CGPointMake(299.5, 116.5)],
                       [NSValue valueWithCGPoint:CGPointMake(298.5, 122.5)],
                       [NSValue valueWithCGPoint:CGPointMake(295.5, 129.5)],
                       [NSValue valueWithCGPoint:CGPointMake(292.5, 133.5)],
                       [NSValue valueWithCGPoint:CGPointMake(289.5, 139.5)],
                       [NSValue valueWithCGPoint:CGPointMake(285.5, 146.5)],
                       [NSValue valueWithCGPoint:CGPointMake(284.5, 151.5)],nil];
  NSArray *Theflume = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(309, 89)],
                       [NSValue valueWithCGPoint:CGPointMake(316, 92)],
                       [NSValue valueWithCGPoint:CGPointMake(322, 94)],
                       [NSValue valueWithCGPoint:CGPointMake(329, 95)],
                       [NSValue valueWithCGPoint:CGPointMake(336, 96)],
                       [NSValue valueWithCGPoint:CGPointMake(341, 98)],
                       [NSValue valueWithCGPoint:CGPointMake(345, 98)],
                       [NSValue valueWithCGPoint:CGPointMake(349, 98)],nil];
  NSArray *Powderbowl = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(323, 73.5)],
                       [NSValue valueWithCGPoint:CGPointMake(323, 81.5)],
                       [NSValue valueWithCGPoint:CGPointMake(321, 93.5)],
                       [NSValue valueWithCGPoint:CGPointMake(321, 99.5)],
                       [NSValue valueWithCGPoint:CGPointMake(317, 107.5)],
                       [NSValue valueWithCGPoint:CGPointMake(314, 115.5)],
                       [NSValue valueWithCGPoint:CGPointMake(311, 121.5)],
                       [NSValue valueWithCGPoint:CGPointMake(308, 125.5)],
                       [NSValue valueWithCGPoint:CGPointMake(306, 130.5)],
                       [NSValue valueWithCGPoint:CGPointMake(303, 134.5)],nil];
  NSArray *Powderbowlblue = [[NSArray alloc] initWithObjects:  //    Blue     // Same name, blue and black "Powder bowl"
                         [NSValue valueWithCGPoint:CGPointMake(309.5, 126)],
                         [NSValue valueWithCGPoint:CGPointMake(305.5, 130)],
                         [NSValue valueWithCGPoint:CGPointMake(299.5, 136)],
                         [NSValue valueWithCGPoint:CGPointMake(295.5, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(291.5, 146)],
                         [NSValue valueWithCGPoint:CGPointMake(287.5, 154)],
                         [NSValue valueWithCGPoint:CGPointMake(282.5, 160)],
                         [NSValue valueWithCGPoint:CGPointMake(279.5, 165)],
                         [NSValue valueWithCGPoint:CGPointMake(277.5, 171)],nil];
  NSArray *Uppergrousealley = [[NSArray alloc] initWithObjects:  //    Black
                         [NSValue valueWithCGPoint:CGPointMake(369.6, 61)],
                         [NSValue valueWithCGPoint:CGPointMake(367.5, 67)],
                         [NSValue valueWithCGPoint:CGPointMake(364.5, 72)],
                         [NSValue valueWithCGPoint:CGPointMake(361.5, 78)],
                         [NSValue valueWithCGPoint:CGPointMake(356.5, 85)],
                         [NSValue valueWithCGPoint:CGPointMake(351.5, 92)],
                         [NSValue valueWithCGPoint:CGPointMake(348.5, 97)],
                         [NSValue valueWithCGPoint:CGPointMake(343.5, 102)],
                         [NSValue valueWithCGPoint:CGPointMake(339.5, 105)],
                         [NSValue valueWithCGPoint:CGPointMake(335.5, 107)],
                         [NSValue valueWithCGPoint:CGPointMake(330.5, 111)],
                         [NSValue valueWithCGPoint:CGPointMake(327.5, 116)],nil];
  NSArray *Lowergrousealley = [[NSArray alloc] initWithObjects:  //    Blue
                               [NSValue valueWithCGPoint:CGPointMake(332.5, 110)],
                               [NSValue valueWithCGPoint:CGPointMake(329.5, 114)],
                               [NSValue valueWithCGPoint:CGPointMake(326.5, 118)],
                               [NSValue valueWithCGPoint:CGPointMake(324.5, 120)],
                               [NSValue valueWithCGPoint:CGPointMake(320.5, 125)],
                               [NSValue valueWithCGPoint:CGPointMake(317.5, 130)],
                               [NSValue valueWithCGPoint:CGPointMake(314.5, 134)],
                               [NSValue valueWithCGPoint:CGPointMake(310.5, 138)],
                               [NSValue valueWithCGPoint:CGPointMake(307.5, 144)],
                               [NSValue valueWithCGPoint:CGPointMake(305.5, 147)],
                               [NSValue valueWithCGPoint:CGPointMake(301.5, 152)],
                               [NSValue valueWithCGPoint:CGPointMake(296.5, 160)],nil];
  
  NSArray *Axhandle = [[NSArray alloc] initWithObjects:  //    Blue
                               [NSValue valueWithCGPoint:CGPointMake(375, 114)],
                               [NSValue valueWithCGPoint:CGPointMake(368, 116)],
                               [NSValue valueWithCGPoint:CGPointMake(361, 120)],
                               [NSValue valueWithCGPoint:CGPointMake(355, 123.5)],
                               [NSValue valueWithCGPoint:CGPointMake(346, 130)],
                               [NSValue valueWithCGPoint:CGPointMake(342, 132)],
                               [NSValue valueWithCGPoint:CGPointMake(336, 134)],
                               [NSValue valueWithCGPoint:CGPointMake(331, 138)],
                               [NSValue valueWithCGPoint:CGPointMake(325, 143)],
                               [NSValue valueWithCGPoint:CGPointMake(320, 148)],
                               [NSValue valueWithCGPoint:CGPointMake(314, 151)],
                               [NSValue valueWithCGPoint:CGPointMake(309, 155)],
                               [NSValue valueWithCGPoint:CGPointMake(302, 159)],
                               [NSValue valueWithCGPoint:CGPointMake(297, 163)],
                               [NSValue valueWithCGPoint:CGPointMake(294, 167)],
                               [NSValue valueWithCGPoint:CGPointMake(291, 169)],
                               [NSValue valueWithCGPoint:CGPointMake(287, 173)],
                               [NSValue valueWithCGPoint:CGPointMake(286, 175)],
                               [NSValue valueWithCGPoint:CGPointMake(284, 178)],
                               [NSValue valueWithCGPoint:CGPointMake(283, 183)],
                               [NSValue valueWithCGPoint:CGPointMake(283, 186)],nil];
  NSArray *Cascades = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(276.5, 208)],
                       [NSValue valueWithCGPoint:CGPointMake(273.5, 214)],
                       [NSValue valueWithCGPoint:CGPointMake(269.5, 220)],
                       [NSValue valueWithCGPoint:CGPointMake(268.5, 223)],
                       [NSValue valueWithCGPoint:CGPointMake(264.5, 230)],
                       [NSValue valueWithCGPoint:CGPointMake(262.5, 232)],
                       [NSValue valueWithCGPoint:CGPointMake(260.5, 236)],
                       [NSValue valueWithCGPoint:CGPointMake(259.5, 238)],
                       [NSValue valueWithCGPoint:CGPointMake(257.5, 241)],nil];
  NSArray *Uppermainstreet = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(249.5, 250)],
                       [NSValue valueWithCGPoint:CGPointMake(245.5, 255)],
                       [NSValue valueWithCGPoint:CGPointMake(242.5, 260)],
                       [NSValue valueWithCGPoint:CGPointMake(239.5, 265)],
                       [NSValue valueWithCGPoint:CGPointMake(234.5, 271)],
                       [NSValue valueWithCGPoint:CGPointMake(230.5, 275)],
                       [NSValue valueWithCGPoint:CGPointMake(227.5, 280)],
                       [NSValue valueWithCGPoint:CGPointMake(223.5, 282)],
                       [NSValue valueWithCGPoint:CGPointMake(221.5, 285)],
                       [NSValue valueWithCGPoint:CGPointMake(218.5, 287)],nil];
  NSArray *Corridor = [[NSArray alloc] initWithObjects:  //    Black
                              [NSValue valueWithCGPoint:CGPointMake(370.5, 71.5)],
                              [NSValue valueWithCGPoint:CGPointMake(368.5, 75.5)],
                              [NSValue valueWithCGPoint:CGPointMake(366.5, 79.5)],
                              [NSValue valueWithCGPoint:CGPointMake(363.5, 82.5)],
                              [NSValue valueWithCGPoint:CGPointMake(361.5, 85.5)],
                              [NSValue valueWithCGPoint:CGPointMake(359.5, 89.5)],
                              [NSValue valueWithCGPoint:CGPointMake(357.5, 92.5)],
                              [NSValue valueWithCGPoint:CGPointMake(355.5, 95.5)],
                              [NSValue valueWithCGPoint:CGPointMake(353.5, 98.5)],
                              [NSValue valueWithCGPoint:CGPointMake(352.5, 100.5)],nil];
  NSArray *Theplunge = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(379.5, 71)],
                       [NSValue valueWithCGPoint:CGPointMake(376.5, 77)],
                       [NSValue valueWithCGPoint:CGPointMake(373.5, 80.5)],
                       [NSValue valueWithCGPoint:CGPointMake(370.5, 84.5)],
                       [NSValue valueWithCGPoint:CGPointMake(368.5, 88.5)],
                       [NSValue valueWithCGPoint:CGPointMake(363.5, 94.5)],
                       [NSValue valueWithCGPoint:CGPointMake(361.5, 98.5)],
                       [NSValue valueWithCGPoint:CGPointMake(358.5, 100.5)],
                       [NSValue valueWithCGPoint:CGPointMake(355.5, 107.5)],nil];
  
  NSArray *Springboard = [[NSArray alloc] initWithObjects:  //    Black
                        [NSValue valueWithCGPoint:CGPointMake(385.5, 95.5)],
                        [NSValue valueWithCGPoint:CGPointMake(380.5, 98.5)],
                        [NSValue valueWithCGPoint:CGPointMake(375.5, 102.5)],
                        [NSValue valueWithCGPoint:CGPointMake(371.5, 106.5)],
                        [NSValue valueWithCGPoint:CGPointMake(368.5, 108.5)],
                        [NSValue valueWithCGPoint:CGPointMake(365.5, 110.5)],
                        [NSValue valueWithCGPoint:CGPointMake(361.5, 113.5)],
                        [NSValue valueWithCGPoint:CGPointMake(355.5, 114.5)],
                        [NSValue valueWithCGPoint:CGPointMake(352.5, 116.5)],
                        [NSValue valueWithCGPoint:CGPointMake(348, 117.5)],nil];
  NSArray *Stumpalley = [[NSArray alloc] initWithObjects:  //    Blue
                         [NSValue valueWithCGPoint:CGPointMake(362.5, 135.5)],
                         [NSValue valueWithCGPoint:CGPointMake(354.4, 138.5)],
                         [NSValue valueWithCGPoint:CGPointMake(349.5, 142.5)],
                         [NSValue valueWithCGPoint:CGPointMake(346.5, 145.5)],
                         [NSValue valueWithCGPoint:CGPointMake(343.5, 148.5)],
                         [NSValue valueWithCGPoint:CGPointMake(337.5, 151.5)],
                         [NSValue valueWithCGPoint:CGPointMake(333.5, 155.5)],
                         [NSValue valueWithCGPoint:CGPointMake(330.5, 159.5)],
                         [NSValue valueWithCGPoint:CGPointMake(323.5, 162)],nil];
  
  NSArray *Luggis = [[NSArray alloc] initWithObjects:  //    Blue
                         [NSValue valueWithCGPoint:CGPointMake(340.5, 162)],
                         [NSValue valueWithCGPoint:CGPointMake(334.5, 165)],
                         [NSValue valueWithCGPoint:CGPointMake(328.5, 167)],
                         [NSValue valueWithCGPoint:CGPointMake(323.5, 171)],
                         [NSValue valueWithCGPoint:CGPointMake(318.5, 172)],
                         [NSValue valueWithCGPoint:CGPointMake(313.5, 174)],
                         [NSValue valueWithCGPoint:CGPointMake(310.5, 175)],nil];
  NSArray *Goldmine = [[NSArray alloc] initWithObjects:  //    Blue
                     [NSValue valueWithCGPoint:CGPointMake(297, 196.5)],
                     [NSValue valueWithCGPoint:CGPointMake(301, 198)],
                     [NSValue valueWithCGPoint:CGPointMake(304, 199)],
                     [NSValue valueWithCGPoint:CGPointMake(309, 201)],
                     [NSValue valueWithCGPoint:CGPointMake(314, 202)],
                     [NSValue valueWithCGPoint:CGPointMake(319, 204)],
                     [NSValue valueWithCGPoint:CGPointMake(323, 205)],
                     [NSValue valueWithCGPoint:CGPointMake(326, 205)],
                     [NSValue valueWithCGPoint:CGPointMake(330, 206)],nil];
  
  NSArray *Bibboom = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(309.5, 214)],
                       [NSValue valueWithCGPoint:CGPointMake(302.5, 217)],
                       [NSValue valueWithCGPoint:CGPointMake(297.5, 220)],
                       [NSValue valueWithCGPoint:CGPointMake(293.5, 225)],
                       [NSValue valueWithCGPoint:CGPointMake(289.5, 226)],
                       [NSValue valueWithCGPoint:CGPointMake(286, 229)],
                       [NSValue valueWithCGPoint:CGPointMake(279, 233)],
                       [NSValue valueWithCGPoint:CGPointMake(275, 235)],
                       [NSValue valueWithCGPoint:CGPointMake(268, 239)],nil];
  
  NSArray *Sodergrens = [[NSArray alloc] initWithObjects:  //    Blue
                      [NSValue valueWithCGPoint:CGPointMake(261.5, 275.5)],
                      [NSValue valueWithCGPoint:CGPointMake(265.5, 273.5)],
                      [NSValue valueWithCGPoint:CGPointMake(271.5, 268.5)],
                      [NSValue valueWithCGPoint:CGPointMake(276.5, 262.5)],
                      [NSValue valueWithCGPoint:CGPointMake(281.5, 259.5)],
                      [NSValue valueWithCGPoint:CGPointMake(286.5, 255.5)],
                      [NSValue valueWithCGPoint:CGPointMake(290.5, 253.5)],
                      [NSValue valueWithCGPoint:CGPointMake(292.5, 248.5)],
                      [NSValue valueWithCGPoint:CGPointMake(298.5, 248.5)],nil];
  
  NSArray *Christmastree = [[NSArray alloc] initWithObjects:  //    Blue
                         [NSValue valueWithCGPoint:CGPointMake(319.5, 237)],
                         [NSValue valueWithCGPoint:CGPointMake(313.5, 239)],
                         [NSValue valueWithCGPoint:CGPointMake(307.5, 241)],
                         [NSValue valueWithCGPoint:CGPointMake(302.5, 242)],
                         [NSValue valueWithCGPoint:CGPointMake(296.5, 242)],
                         [NSValue valueWithCGPoint:CGPointMake(291.5, 243)],
                         [NSValue valueWithCGPoint:CGPointMake(283.5, 245)],
                         [NSValue valueWithCGPoint:CGPointMake(278.5, 246)],
                         [NSValue valueWithCGPoint:CGPointMake(273.5, 247)],
                         [NSValue valueWithCGPoint:CGPointMake(269.5, 247)],
                         [NSValue valueWithCGPoint:CGPointMake(264.5, 247)],nil];
  
  NSArray *Thestash = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(287.5, 294)],
                            [NSValue valueWithCGPoint:CGPointMake(281.5, 295)],
                            [NSValue valueWithCGPoint:CGPointMake(275.5, 299)],
                            [NSValue valueWithCGPoint:CGPointMake(269.5, 301)],
                            [NSValue valueWithCGPoint:CGPointMake(261.5, 304)],
                            [NSValue valueWithCGPoint:CGPointMake(257.5, 305)],
                            [NSValue valueWithCGPoint:CGPointMake(253.5, 307)],
                            [NSValue valueWithCGPoint:CGPointMake(250.5, 308)],nil];
  
  NSArray *Hootowl = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(304.5, 294)],
                       [NSValue valueWithCGPoint:CGPointMake(300.5, 296)],
                       [NSValue valueWithCGPoint:CGPointMake(297.5, 297)],
                       [NSValue valueWithCGPoint:CGPointMake(293.5, 299)],
                       [NSValue valueWithCGPoint:CGPointMake(288.5, 302)],
                       [NSValue valueWithCGPoint:CGPointMake(285.5, 302)],
                       [NSValue valueWithCGPoint:CGPointMake(280.5, 305)],
                       [NSValue valueWithCGPoint:CGPointMake(274.5, 307)],
                       [NSValue valueWithCGPoint:CGPointMake(270.5, 308)],nil];
  
  NSArray *Lowerpionner = [[NSArray alloc] initWithObjects:  //    Blue
                      [NSValue valueWithCGPoint:CGPointMake(306, 300)],
                      [NSValue valueWithCGPoint:CGPointMake(295.5, 305)],
                      [NSValue valueWithCGPoint:CGPointMake(288.5, 307)],
                      [NSValue valueWithCGPoint:CGPointMake(283.5, 310)],
                      [NSValue valueWithCGPoint:CGPointMake(278, 312)],
                      [NSValue valueWithCGPoint:CGPointMake(273, 314)],
                      [NSValue valueWithCGPoint:CGPointMake(269, 317)],
                      [NSValue valueWithCGPoint:CGPointMake(265, 319)],nil];
  
  NSArray *Upperpionner = [[NSArray alloc] initWithObjects:  //    Blue
                           [NSValue valueWithCGPoint:CGPointMake(351.5, 244.5)],
                           [NSValue valueWithCGPoint:CGPointMake(349.5, 248.5)],
                           [NSValue valueWithCGPoint:CGPointMake(347.5, 252.5)],
                           [NSValue valueWithCGPoint:CGPointMake(343.5, 257.5)],
                           [NSValue valueWithCGPoint:CGPointMake(342.5, 260.5)],
                           [NSValue valueWithCGPoint:CGPointMake(340.5, 264.5)],
                           [NSValue valueWithCGPoint:CGPointMake(335.5, 269.5)],
                           [NSValue valueWithCGPoint:CGPointMake(331.5, 275.5)],
                           [NSValue valueWithCGPoint:CGPointMake(328.5, 280.5)],
                           [NSValue valueWithCGPoint:CGPointMake(323.5, 285.5)],
                           [NSValue valueWithCGPoint:CGPointMake(320.5, 287.5)],nil];
  
  NSArray *Thegully = [[NSArray alloc] initWithObjects:  //    Blue
                           [NSValue valueWithCGPoint:CGPointMake(321, 264.5)],
                           [NSValue valueWithCGPoint:CGPointMake(317, 267.5)],
                           [NSValue valueWithCGPoint:CGPointMake(312, 270.5)],
                           [NSValue valueWithCGPoint:CGPointMake(308, 272.5)],
                           [NSValue valueWithCGPoint:CGPointMake(303, 275.5)],
                           [NSValue valueWithCGPoint:CGPointMake(296, 278.5)],
                           [NSValue valueWithCGPoint:CGPointMake(292, 279.5)],
                           [NSValue valueWithCGPoint:CGPointMake(288, 280.5)],
                           [NSValue valueWithCGPoint:CGPointMake(284, 280.5)],
                           [NSValue valueWithCGPoint:CGPointMake(280, 282.5)],nil];
  
  NSArray *Boondocks = [[NSArray alloc] initWithObjects:  //    Blue
                           [NSValue valueWithCGPoint:CGPointMake(380.5, 273.5)],
                           [NSValue valueWithCGPoint:CGPointMake(375.5, 275.5)],
                           [NSValue valueWithCGPoint:CGPointMake(371.5, 277.5)],
                           [NSValue valueWithCGPoint:CGPointMake(369.5, 279.5)],
                           [NSValue valueWithCGPoint:CGPointMake(365.5, 281.5)],
                           [NSValue valueWithCGPoint:CGPointMake(358.5, 284.5)],
                           [NSValue valueWithCGPoint:CGPointMake(353.5, 287.5)],
                           [NSValue valueWithCGPoint:CGPointMake(345.5, 291.5)],
                           [NSValue valueWithCGPoint:CGPointMake(335.5, 296.5)],
                           [NSValue valueWithCGPoint:CGPointMake(326.5, 300.5)],
                           [NSValue valueWithCGPoint:CGPointMake(318.5, 302.5)],
                           [NSValue valueWithCGPoint:CGPointMake(312.5, 306.5)],
                           [NSValue valueWithCGPoint:CGPointMake(302.5, 310.5)],
                           [NSValue valueWithCGPoint:CGPointMake(295.5, 314.5)],
                           [NSValue valueWithCGPoint:CGPointMake(293.5, 317.5)],
                           [NSValue valueWithCGPoint:CGPointMake(289.5, 320.5)],
                           [NSValue valueWithCGPoint:CGPointMake(285.5, 323.5)],nil];
  
  NSArray *Overlandtrail = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(262.5, 359.5)],
                       [NSValue valueWithCGPoint:CGPointMake(271.5, 359)],
                       [NSValue valueWithCGPoint:CGPointMake(274.5, 357.5)],
                       [NSValue valueWithCGPoint:CGPointMake(283.5, 360.5)],
                       [NSValue valueWithCGPoint:CGPointMake(289.5, 362)],nil];
  
  NSArray *Northernlights = [[NSArray alloc] initWithObjects:  //    Blue
                        [NSValue valueWithCGPoint:CGPointMake(342, 217)],
                        [NSValue valueWithCGPoint:CGPointMake(334, 221)],
                        [NSValue valueWithCGPoint:CGPointMake(328, 223)],
                        [NSValue valueWithCGPoint:CGPointMake(319, 228)],
                        [NSValue valueWithCGPoint:CGPointMake(314, 230)],
                        [NSValue valueWithCGPoint:CGPointMake(310, 232)],
                        [NSValue valueWithCGPoint:CGPointMake(306, 234)],
                        [NSValue valueWithCGPoint:CGPointMake(302, 236)],
                        [NSValue valueWithCGPoint:CGPointMake(297, 238)],nil];
  
  NSArray *Flyingsqurrel = [[NSArray alloc] initWithObjects:  //    Black
                             [NSValue valueWithCGPoint:CGPointMake(340, 198.5)],
                             [NSValue valueWithCGPoint:CGPointMake(335, 203.5)],
                             [NSValue valueWithCGPoint:CGPointMake(330, 207.5)],
                             [NSValue valueWithCGPoint:CGPointMake(327, 210.5)],
                             [NSValue valueWithCGPoint:CGPointMake(324, 213.5)],
                             [NSValue valueWithCGPoint:CGPointMake(320, 216.5)],
                             [NSValue valueWithCGPoint:CGPointMake(316, 220.5)],
                             [NSValue valueWithCGPoint:CGPointMake(309, 223.5)],
                             [NSValue valueWithCGPoint:CGPointMake(305, 226.5)],
                             [NSValue valueWithCGPoint:CGPointMake(300, 228.5)],
                             [NSValue valueWithCGPoint:CGPointMake(295, 230.5)],nil];
  
  NSArray *Lookoutroad = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(360.5, 173.5)],
                            [NSValue valueWithCGPoint:CGPointMake(363.5, 177.5)],
                            [NSValue valueWithCGPoint:CGPointMake(364.5, 181.5)],
                            [NSValue valueWithCGPoint:CGPointMake(365.5, 184.5)],
                            [NSValue valueWithCGPoint:CGPointMake(367.5, 189.5)],
                            [NSValue valueWithCGPoint:CGPointMake(368.5, 192.5)],
                            [NSValue valueWithCGPoint:CGPointMake(368.5, 197.5)],
                            [NSValue valueWithCGPoint:CGPointMake(369.5, 200.5)],nil];
  
  NSArray *Cowboypass = [[NSArray alloc] initWithObjects:  //    Black
                          [NSValue valueWithCGPoint:CGPointMake(333.5, 213)],
                          [NSValue valueWithCGPoint:CGPointMake(337.5, 211)],
                          [NSValue valueWithCGPoint:CGPointMake(343.5, 209)],
                          [NSValue valueWithCGPoint:CGPointMake(348.5, 207)],
                          [NSValue valueWithCGPoint:CGPointMake(354.5, 204)],
                          [NSValue valueWithCGPoint:CGPointMake(360.5, 202)],
                          [NSValue valueWithCGPoint:CGPointMake(365.5, 197)],
                          [NSValue valueWithCGPoint:CGPointMake(368.5, 195)],nil];
  
  NSArray *Upperjibboom = [[NSArray alloc] initWithObjects:  //    Blue
                         [NSValue valueWithCGPoint:CGPointMake(353, 172)],
                         [NSValue valueWithCGPoint:CGPointMake(348, 176)],
                         [NSValue valueWithCGPoint:CGPointMake(341, 179)],
                         [NSValue valueWithCGPoint:CGPointMake(336, 183)],
                         [NSValue valueWithCGPoint:CGPointMake(332, 188)],
                         [NSValue valueWithCGPoint:CGPointMake(329, 191)],
                         [NSValue valueWithCGPoint:CGPointMake(325, 194)],
                         [NSValue valueWithCGPoint:CGPointMake(322, 196)],
                         [NSValue valueWithCGPoint:CGPointMake(320, 198)],
                         [NSValue valueWithCGPoint:CGPointMake(318, 200)],
                         [NSValue valueWithCGPoint:CGPointMake(315, 203)],nil];
  
  NSArray *Comstockglade = [[NSArray alloc] initWithObjects:  //    Black
                           [NSValue valueWithCGPoint:CGPointMake(355.5, 161)],
                           [NSValue valueWithCGPoint:CGPointMake(349.5, 163)],
                           [NSValue valueWithCGPoint:CGPointMake(345.5, 166)],
                           [NSValue valueWithCGPoint:CGPointMake(340.5, 169)],
                           [NSValue valueWithCGPoint:CGPointMake(336.5, 171)],
                           [NSValue valueWithCGPoint:CGPointMake(332.5, 174)],
                           [NSValue valueWithCGPoint:CGPointMake(328.5, 177)],
                           [NSValue valueWithCGPoint:CGPointMake(326.5, 179)],
                           [NSValue valueWithCGPoint:CGPointMake(322.5, 180)],
                           [NSValue valueWithCGPoint:CGPointMake(320.5, 183)],
                           [NSValue valueWithCGPoint:CGPointMake(317.5, 185)],
                           [NSValue valueWithCGPoint:CGPointMake(315.5, 188)],
                           [NSValue valueWithCGPoint:CGPointMake(313.5, 190)],
                           [NSValue valueWithCGPoint:CGPointMake(311.5, 192)],nil];
  NSArray *Westridge = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(380, 127)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 130)],
                            [NSValue valueWithCGPoint:CGPointMake(372, 135)],
                            [NSValue valueWithCGPoint:CGPointMake(370, 139)],
                            [NSValue valueWithCGPoint:CGPointMake(368, 143)],
                            [NSValue valueWithCGPoint:CGPointMake(364, 148)],
                            [NSValue valueWithCGPoint:CGPointMake(361, 153)],
                            [NSValue valueWithCGPoint:CGPointMake(359, 157)],
                            [NSValue valueWithCGPoint:CGPointMake(359, 159)],nil];
  
  NSArray *Lookoutbypass = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(362, 251)],
                            [NSValue valueWithCGPoint:CGPointMake(361, 258)],
                            [NSValue valueWithCGPoint:CGPointMake(357, 267)],
                            [NSValue valueWithCGPoint:CGPointMake(355, 273)],
                            [NSValue valueWithCGPoint:CGPointMake(352, 278)],
                            [NSValue valueWithCGPoint:CGPointMake(348, 286)],
                            [NSValue valueWithCGPoint:CGPointMake(343, 292)],
                            [NSValue valueWithCGPoint:CGPointMake(334, 300)],
                            [NSValue valueWithCGPoint:CGPointMake(325, 307)],
                            [NSValue valueWithCGPoint:CGPointMake(317, 314)],
                            [NSValue valueWithCGPoint:CGPointMake(308, 323)],
                            [NSValue valueWithCGPoint:CGPointMake(302, 330)],
                            [NSValue valueWithCGPoint:CGPointMake(301, 339)],
                            [NSValue valueWithCGPoint:CGPointMake(304, 352)],
                            [NSValue valueWithCGPoint:CGPointMake(305, 360)],
                            [NSValue valueWithCGPoint:CGPointMake(309, 367)],
                            [NSValue valueWithCGPoint:CGPointMake(314, 372)],
                            [NSValue valueWithCGPoint:CGPointMake(321, 376)],
                            [NSValue valueWithCGPoint:CGPointMake(328, 379)],
                            [NSValue valueWithCGPoint:CGPointMake(334, 381)],nil];
  
  NSArray *Drifterconnector = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(375.5, 146)],
                            [NSValue valueWithCGPoint:CGPointMake(375.5, 151)],
                            [NSValue valueWithCGPoint:CGPointMake(374.5, 157)],
                            [NSValue valueWithCGPoint:CGPointMake(376.5, 163)],
                            [NSValue valueWithCGPoint:CGPointMake(375.5, 170)],
                            [NSValue valueWithCGPoint:CGPointMake(377.5, 182)],
                            [NSValue valueWithCGPoint:CGPointMake(379.5, 190)],
                            [NSValue valueWithCGPoint:CGPointMake(380.5, 195)],
                            [NSValue valueWithCGPoint:CGPointMake(382.5, 200)],
                            [NSValue valueWithCGPoint:CGPointMake(383.5, 205)],
                            [NSValue valueWithCGPoint:CGPointMake(388.5, 208)],
                            [NSValue valueWithCGPoint:CGPointMake(377.5, 166)],nil];
  
  NSArray *Theface = [[NSArray alloc] initWithObjects:  //    Black
                               [NSValue valueWithCGPoint:CGPointMake(382, 250.5)],
                               [NSValue valueWithCGPoint:CGPointMake(377, 255.5)],
                               [NSValue valueWithCGPoint:CGPointMake(374, 257.5)],
                               [NSValue valueWithCGPoint:CGPointMake(369, 259)],
                               [NSValue valueWithCGPoint:CGPointMake(365, 261)],
                               [NSValue valueWithCGPoint:CGPointMake(362, 262)],
                               [NSValue valueWithCGPoint:CGPointMake(358, 266)],nil];
  
  NSArray *Sierragrande = [[NSArray alloc] initWithObjects:  //    Black
                      [NSValue valueWithCGPoint:CGPointMake(422, 44)],
                      [NSValue valueWithCGPoint:CGPointMake(429, 44)],
                      [NSValue valueWithCGPoint:CGPointMake(436, 45)],
                      [NSValue valueWithCGPoint:CGPointMake(445, 47)],
                      [NSValue valueWithCGPoint:CGPointMake(452.5, 49)],
                      [NSValue valueWithCGPoint:CGPointMake(459.5, 50)],
                      [NSValue valueWithCGPoint:CGPointMake(466.6, 53)],
                      [NSValue valueWithCGPoint:CGPointMake(471.5, 57)],
                           [NSValue valueWithCGPoint:CGPointMake(474.500000, 61.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(479.500000, 66.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(483.500000, 69.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(490.500000, 72.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(493.500000, 74.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(496.500000, 78.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(501.500000, 83.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(506.500000, 88.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(511.500000, 94.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(516.500000, 101.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(522.500000, 108.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(527.500000, 111.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(531.500000, 116.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(538.500000, 120.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(543.500000, 123.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(551.500000, 128.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(558.500000, 134.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(563.500000, 138.500000)],nil];
  
  NSArray *Challenger = [[NSArray alloc] initWithObjects:  //    Black
                         [NSValue valueWithCGPoint:CGPointMake(508.000000, 72.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(514.000000, 76.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(518.000000, 81.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(524.000000, 85.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(531.000000, 89.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(544.000000, 93.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(551.000000, 96.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(550.500000, 98.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(561.500000, 101.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(569.500000, 105.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(578.500000, 107.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(585.500000, 110.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(592.500000, 110.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(600.500000, 113.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(609.500000, 116.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(613.500000, 118.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(620.500000, 121.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(624.500000, 124.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(620.500000, 131.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(615.500000, 135.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(611.500000, 140.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(607.500000, 143.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(603.500000, 146.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(599.500000, 149.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(596.500000, 153.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(593.500000, 156.500000)],nil];
  
  NSArray *Followme = [[NSArray alloc] initWithObjects:  //    Black
                         [NSValue valueWithCGPoint:CGPointMake(563.500000, 113.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(566.500000, 119.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(569.500000, 125.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(571.500000, 131.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(575.500000, 137.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(578.500000, 143.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(580.500000, 148.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(583.500000, 152.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(587.500000, 155.500000)],nil];
  
  NSArray *Railspiltter = [[NSArray alloc] initWithObjects:  //    Black
                         [NSValue valueWithCGPoint:CGPointMake(438.000000, 56.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(442.000000, 60.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(448.500000, 64.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(454.500000, 69.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(461.500000, 73.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(466.500000, 79.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(474.500000, 82.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(482.500000, 88.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(491.500000, 95.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(495.500000, 98.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(501.500000, 103.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(506.500000, 107.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(513.500000, 113.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(520.500000, 118.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(527.500000, 123.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(536.500000, 128.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(543.500000, 132.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(550.500000, 137.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(560.500000, 142.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(569.500000, 147.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(579.500000, 151.500000)],nil];
  
  NSArray *Monumentglade = [[NSArray alloc] initWithObjects:  //    Black
                           [NSValue valueWithCGPoint:CGPointMake(454.500000, 82.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(460.500000, 87.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(468.500000, 92.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(474.500000, 98.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(483.500000, 104.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(489.500000, 109.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(497.500000, 115.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(506.500000, 122.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(514.500000, 127.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(522.500000, 133.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(529.500000, 139.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(539.500000, 146.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(548.500000, 150.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(560.500000, 158.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(566.500000, 164.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(573.500000, 169.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(579.500000, 173.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(586.500000, 176.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(589.500000, 182.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(591.500000, 187.000000)],nil];
  
  NSArray *Burnout = [[NSArray alloc] initWithObjects:  //    Black
                            [NSValue valueWithCGPoint:CGPointMake(410.500000, 59.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(417.500000, 65.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(427.500000, 71.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(437.500000, 81.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(444.500000, 85.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(451.500000, 91.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(459.500000, 98.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(467.500000, 105.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(475.500000, 111.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(482.500000, 117.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(490.500000, 123.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(497.500000, 130.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(504.500000, 135.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(510.500000, 140.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(516.500000, 145.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(523.500000, 151.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(531.500000, 156.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(537.500000, 161.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(544.500000, 165.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(549.500000, 170.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(556.500000, 174.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(562.500000, 178.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(570.500000, 185.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(576.500000, 187.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(582.500000, 192.000000)],nil];
  
  
  NSArray *Therapids = [[NSArray alloc] initWithObjects:  //    Black
                      [NSValue valueWithCGPoint:CGPointMake(409.000000, 66.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(414.000000, 71.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(418.000000, 75.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(423.000000, 81.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(429.000000, 86.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(435.000000, 93.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(440.000000, 98.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(446.000000, 103.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(452.000000, 109.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(458.000000, 117.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(465.000000, 124.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(472.000000, 131.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(478.000000, 139.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(485.000000, 147.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(492.000000, 155.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(499.000000, 162.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(507.000000, 172.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(516.000000, 181.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(521.000000, 187.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(528.000000, 194.00000)],
                      [NSValue valueWithCGPoint:CGPointMake(536.000000, 202.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(547.000000, 212.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(561.000000, 224.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(569.000000, 236.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(581.000000, 243.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(591.000000, 250.000000)],nil];
  
  
  NSArray *Polaris = [[NSArray alloc] initWithObjects:  //    Black
                        [NSValue valueWithCGPoint:CGPointMake(404.500000, 77.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(408.500000, 82.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(418.500000, 92.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(425.500000, 99.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(429.000000, 86.000000)],
                        [NSValue valueWithCGPoint:CGPointMake(431.500000, 103.50000)],
                        [NSValue valueWithCGPoint:CGPointMake(437.500000, 111.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(443.500000, 117.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(448.500000, 121.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(455.500000, 133.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(461.500000, 138.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(467.500000, 146.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(472.500000, 153.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(476.500000, 160.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(482.500000, 169.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(488.500000, 174.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(495.500000, 180.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(501.500000, 186.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(508.500000, 191.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(512.500000, 196.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(518.500000, 199.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(526.500000, 204.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(533.500000, 210.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(539.500000, 215.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(543.500000, 219.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(550.500000, 225.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(554.500000, 230.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(561.500000, 237.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(569.500000, 244.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(577.500000, 251.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(587.500000, 257.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(595.500000, 258.500000)],nil];
  


  NSMutableArray *pointsArray = [NSMutableArray new];
  [pointsArray addObject:Hornetsnest];
  [pointsArray addObject:Polaris];
  [pointsArray addObject:Therapids];
  [pointsArray addObject:Burnout];
  [pointsArray addObject:Monumentglade];
  [pointsArray addObject:Railspiltter];
  [pointsArray addObject:Followme];
  [pointsArray addObject:Challenger];
  [pointsArray addObject:Sierragrande];
  [pointsArray addObject:Theface];
  [pointsArray addObject:Drifterconnector];
  [pointsArray addObject:Lookoutbypass];
  [pointsArray addObject:Westridge];
  [pointsArray addObject:Upperjibboom];
  [pointsArray addObject:Comstockglade];
  [pointsArray addObject:Cowboypass];
  [pointsArray addObject:Lookoutroad];
  [pointsArray addObject:Flyingsqurrel];
  [pointsArray addObject:Northernlights];
  [pointsArray addObject:Overlandtrail];
  [pointsArray addObject:Boondocks];
  [pointsArray addObject:Lowerpionner];
  [pointsArray addObject:Thestash];
  [pointsArray addObject:Thegully];
  [pointsArray addObject:Upperpionner];
  [pointsArray addObject:Hootowl];
  [pointsArray addObject:Christmastree];
  [pointsArray addObject:Sodergrens];
  [pointsArray addObject:Goldmine];
  [pointsArray addObject:Luggis];
  [pointsArray addObject:Bibboom];
  [pointsArray addObject:Stumpalley];
  [pointsArray addObject:Springboard];
  [pointsArray addObject:Theplunge];
  [pointsArray addObject:Corridor];
  [pointsArray addObject:Cascades];
  [pointsArray addObject:Uppermainstreet];
  [pointsArray addObject:Axhandle];
  [pointsArray addObject:Uppergrousealley];
  [pointsArray addObject:Lowergrousealley];
  [pointsArray addObject:Powderbowlblue];
  [pointsArray addObject:Powderbowl];
  [pointsArray addObject:Theflume];
  [pointsArray addObject:Rendezvousglade];
  [pointsArray addObject:Crosscut];
  [pointsArray addObject:Toninis];
  [pointsArray addObject:Thechute];
  [pointsArray addObject:Dutchman];
  [pointsArray addObject:Delight];
  [pointsArray addObject:Eastridge];
  [pointsArray addObject:Upperlionswy];
  [pointsArray addObject:Lowerlionswy];
  [pointsArray addObject:Surprise];
  [pointsArray addObject:Loggersloop];
  [pointsArray addObject:Easystreet];
  [pointsArray addObject:Woodcutter];
  [pointsArray addObject:Timberline];
  [pointsArray addObject:Theglades];
  [pointsArray addObject:Homerun];
  [pointsArray addObject:Coyotefork];
  [pointsArray addObject:Villagerun];
  [pointsArray addObject:Condorun];
  [pointsArray addObject:Thewoods];
  [pointsArray addObject:Catsface];
  [pointsArray addObject:Woodchuck];
  [pointsArray addObject:Moonshine];
  [pointsArray addObject:Pipeline];
  [pointsArray addObject:Dropoff];
  [pointsArray addObject:Thestairs];
  [pointsArray addObject:Pinball];
  [pointsArray addObject:Forerunner];
  [pointsArray addObject:Sidewinder];
  [pointsArray addObject:Magicmoglus];
  [pointsArray addObject:Skidtrail];
  [pointsArray addObject:lumberJack];
  [pointsArray addObject:lowerMainStreet];
  [pointsArray addObject:theGulch];
  
  return pointsArray;

}



- (id)initWithMap:(UIImage*) map
{
  self = [super init];
  if (self) {
    self.map = map;
    self.zoomed = NO;
    self.view.backgroundColor = [UIColor whiteColor];
  }
  return self;
}


- (void)viewDidLoad
{
  NSLog(@"viewDidLoad");
  [super viewDidLoad];
  //get image from library

  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.map.size.width*(self.view.bounds.size.height/self.map.size.height)), self.view.bounds.size.height)];
//  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height * image.size.height / image.size.width))];

  NSLog(@"imageview width is %f, height is %f", self.imageView.bounds.size.width, self.imageView.bounds.size.height);
  self.imageView.image = self.map;
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  NSLog(@"scrollView width is %f, height is %f", self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
  
  self.scrollView.scrollEnabled = YES;
  self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame));
  self.scrollView.showsHorizontalScrollIndicator = YES;
  self.scrollView.showsVerticalScrollIndicator = YES;
  
  //    self.scrollView.scrollsToTop = NO;
  self.scrollView.delegate = self;
  [self.scrollView addSubview:self.imageView];
  [self.view addSubview:self.scrollView];
  
  self.scrollView.minimumZoomScale=1;
  self.scrollView.maximumZoomScale=6.0;

  //    self.scrollView.contentSize=CGSizeMake(1280, 960);
  //    self.scrollView.delegate=self
  //    tap gestures
  //target - what object is going to handle the gesture when it gets recognised
  //the argument for tap: is the gesture that caused this message to be sent
  UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapOnce:)];
  UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapTwice:)];
  
  tapOnce.numberOfTapsRequired = 1;
  tapTwice.numberOfTapsRequired = 2;
  
  //stops tapOnce from overriding tapTwice
  [tapOnce requireGestureRecognizerToFail:tapTwice];
  
  //then need to add the gesture recogniser to a view - this will be the view that recognises the gesture
  [self.scrollView addGestureRecognizer:tapOnce];
  [self.scrollView addGestureRecognizer:tapTwice];
  [self drawNavigationInputs];
  
  self.trailPath = [[trailPathView alloc] initWithFrame:self.imageView.bounds];
  self.trailPath.dataSource = self;
  [self.imageView addSubview:self.trailPath];
  self.trailOn = YES;
  
    [self drawFakeFriend];
    
}


- (void)drawFakeFriend {
    UIImageView *user1 = [[UIImageView alloc] initWithImage:
                          [ARUtility resizeImage:[UIImage imageNamed:@"Brook Alo 03"]
                                        withSize:CGSizeMake(50, 50)]];
    [user1 setCenter:CGPointMake(100, 200)];
    [user1.layer setBorderColor:[UIColor blackColor].CGColor];
    [user1.layer setCornerRadius:user1.bounds.size.width/2];
    [user1.layer setBorderWidth:2.0f];
    user1.clipsToBounds = YES;
    [self.imageView addSubview:user1];
    
    UIImageView *user2 = [[UIImageView alloc] initWithImage:
                          [ARUtility resizeImage:[UIImage imageNamed:@"Carlito Baker 01"]
                                        withSize:CGSizeMake(50, 50)]];
    [user2 setCenter:CGPointMake(150, 250)];
    [user2.layer setBorderColor:[UIColor grayColor].CGColor];
    [user2.layer setCornerRadius:user2.bounds.size.width/2];
    [user2.layer setBorderWidth:2.0f];
    user2.clipsToBounds = YES;
    [self.imageView addSubview:user2];
    
    UIImageView *user3 = [[UIImageView alloc] initWithImage:
                          [ARUtility resizeImage:[UIImage imageNamed:@"Carlos Mugisha 07"]
                                        withSize:CGSizeMake(50, 50)]];
    [user3 setCenter:CGPointMake(250, 200)];
    [user3.layer setBorderColor:[UIColor greenColor].CGColor];
    [user3.layer setCornerRadius:user3.bounds.size.width/2];
    [user3.layer setBorderWidth:2.0f];
    user3.clipsToBounds = YES;
    [self.imageView addSubview:user3];
    
    UIImageView *user4 = [[UIImageView alloc] initWithImage:
                          [ARUtility resizeImage:[UIImage imageNamed:@"Katherine Castelao 08"]
                                        withSize:CGSizeMake(50, 50)]];
    [user4 setCenter:CGPointMake(450, 180)];
    [user4.layer setBorderColor:[UIColor blueColor].CGColor];
    [user4.layer setCornerRadius:user4.bounds.size.width/2];
    [user4.layer setBorderWidth:2.0f];
    user4.clipsToBounds = YES;
    [self.imageView addSubview:user4];
    
}

- (void)drawNavigationInputs
{
  UIImage *background = [UIImage imageNamed:@"mapbutton_bg"];
  UIImageView *bgView = [[UIImageView alloc] initWithImage:background];
  UIView *buttons = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-10-background.size.width, 30, background.size.width+10, background.size.height+10)];
  [buttons addSubview:bgView];
  [buttons sendSubviewToBack:bgView];
  UIImage *zoomOut = [UIImage imageNamed:@"exitfullscreen_button"];
//  UIImage *zoomOut = [UIImage imageNamed:@"fullscreen_button"];
  UIButton *homeView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, zoomOut.size.width, zoomOut.size.height)];
  homeView.center = CGPointMake(background.size.width/2, background.size.height/3.9);
  [homeView addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
  [homeView setBackgroundImage:zoomOut forState:UIControlStateNormal];
  [buttons addSubview:homeView];
  
  UIImage *switchImage = [UIImage imageNamed:@"viewHighlight_button"];
  UIButton *viewSwitch = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, switchImage.size.width, switchImage.size.height)];
  viewSwitch.center = CGPointMake(background.size.width/2, background.size.height/2 + background.size.height/3.9);
  [viewSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
  [viewSwitch setBackgroundImage:switchImage forState:UIControlStateNormal];
  [buttons addSubview:viewSwitch];
  [self.view addSubview: buttons];
  
}

-(void)switchAction:(id)sender
{
  self.trailPath.hidden = self.trailOn;
  self.trailOn = !self.trailOn;
//  if (self.trailOn) {
//    self.trailPath.hidden = YES;
//    self.trailOn = NO;
//  }
}
-(void)homeAction:(id)sender
{
   [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)tapOnce:(UIGestureRecognizer *)gesture
{
  NSLog(@"point is %f, %f", [gesture locationInView:gesture.view].x, [gesture locationInView:gesture.view].y);
  
//  //step 1: find where is being touched
//  CGPoint point = [gesture locationInView:self.scrollView];
//  //step 2: create a top left point
//  point = CGPointMake(point.x - self.scrollView.bounds.size.height/2, point.y - self.scrollView.bounds.size.width/2);
//  //step 3: create a rect using that point
//  CGRect rect = CGRectMake(point.x, point.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//  //on a single  tap, call zoomToRect in UIScrollView
//  [self.scrollView zoomToRect:rect animated:YES];
}


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
  
  CGRect zoomRect;
  
  zoomRect.size.height = [_imageView frame].size.height / scale;
  zoomRect.size.width  = [_imageView frame].size.width  / scale;
  
  center = [_imageView convertPoint:center fromView:self.scrollView];
  
  zoomRect.origin.x    = center.x - ((zoomRect.size.width / 2.0));
  zoomRect.origin.y    = center.y - ((zoomRect.size.height / 2.0));
  
  return zoomRect;
}

- (void)tapTwice:(UIGestureRecognizer *)recognizer
{
  NSLog(@"point is %f, %f", [recognizer locationInView:recognizer.view].x, [recognizer locationInView:recognizer.view].y);
  float newScale = [self.scrollView zoomScale] * 6.0;
  
  if (self.scrollView.zoomScale > self.scrollView.minimumZoomScale)
  {
    [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
  }
  else
  {
    CGRect zoomRect = [self zoomRectForScale:newScale
                                  withCenter:[recognizer locationInView:recognizer.view]];
    [self.scrollView zoomToRect:zoomRect animated:YES];
  }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  //reset zoomScale back to 1 so that contentSize can be modified correctly
  self.scrollView.zoomScale = 1;
  //blah
  self.scrollView.frame = self.view.bounds;
  // reset scrolling area equal to size of image
  self.scrollView.contentSize = self.imageView.bounds.size;
  
  //reset the image frame to the size of the image
  self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
  
  //set the zoomScale to what we actually want
  //    self.scrollView.zoomScale = [self findZoomScale];
}

- (void)viewWillAppear:(BOOL)animated
{
  NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
  NSLog(@"viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  //    NSLog(@"viewForZoomingInScrollView");
  return self.imageView;
}

- (float) get_elv: (NSMutableArray*) data atIndex: (int) i
{
  CLLocation *this_location = [data objectAtIndex:i];
  return this_location.altitude;
}
- (float) get_cll_n: (NSArray *) data atIndex: (int) i
{
//    NSLog(@"get_n is %f",  [[[data objectAtIndex:i] objectAtIndex:1] floatValue    ]);
  CLLocation *this_location = [data objectAtIndex:i];
  return this_location.coordinate.latitude;
}
- (float) get_cll_w: (NSArray *) data atIndex: (int) i
{
//  NSLog(@"get_w is %f",  [[[data objectAtIndex:i] objectAtIndex:2] floatValue    ]);
  CLLocation *this_location = [data objectAtIndex:i];
  return this_location.coordinate.longitude;
}
- (float) get_n: (NSArray *) data atIndex: (int) i
{
  //    NSLog(@"get_n is %f",  [[[data objectAtIndex:i] objectAtIndex:1] floatValue    ]);
  return [[[data objectAtIndex:i] objectAtIndex:1] floatValue    ];
}
- (float) get_w: (NSArray *) data atIndex: (int) i
{
  //  NSLog(@"get_w is %f",  [[[data objectAtIndex:i] objectAtIndex:2] floatValue    ]);
  return [[[data objectAtIndex:i] objectAtIndex:2] floatValue    ];
}
- (NSInteger) get_distance: (NSArray*) user user_index: (int) u_index : (NSArray*) trail : (int) trail_index
{

  NSLog(@"user index is %d <=> trail index is %d", u_index, trail_index);
  NSLog(@"u_index is %d and trail_index is %d and diff is %f", u_index, trail_index, pow(([self get_cll_n:user atIndex:u_index]*100000-[self get_n:trail atIndex:trail_index]*100000), 2) - pow(([self get_cll_w:user atIndex:u_index]*100000-[self get_w:trail atIndex:trail_index]*100000),2));
  NSLog(@"(%f-%f)^2 = %f - (%f-%f)^2 = %f", [self get_cll_n:user atIndex:u_index]*100000, [self get_n:trail atIndex:trail_index]*100000,pow(([self get_cll_n:user atIndex:u_index]*100000-[self get_n:trail atIndex:trail_index]*100000), 2), [self get_cll_w:user atIndex:u_index]*100000,  [self get_w:trail atIndex:trail_index]*100000,  pow(([self get_cll_w:user atIndex:u_index]*100000-[self get_w:trail atIndex:trail_index]*100000),2));
  return ABS(pow(([self get_cll_n:user atIndex:u_index]*100000-[self get_n:trail atIndex:trail_index]*100000), 2) - pow(([self get_cll_w:user atIndex:u_index]*100000-[self get_w:trail atIndex:trail_index]*100000),2));

}


- (NSMutableArray*) jerry_init_data
{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
  NSString *date = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d", 2222, 11, 22, 6, 6, 6];
  NSDate *time = [df dateFromString: date];
  NSMutableArray * artrailpoint_array = [NSMutableArray new];
  
  CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(39.148894, 120.075267);
  ARTrailPoint *tp = [[ARTrailPoint alloc] init]; //ccz: create an object;
  CLLocation *location = [[CLLocation alloc] initWithCoordinate:loc altitude:2292.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [tp setLocation:location]; //ccz: set location
  [artrailpoint_array addObject:tp]; //ccz: save trailpoint
  
  
  //ccz: need to modiefy rest.
  loc = CLLocationCoordinate2DMake(39.148894, 120.075269);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148893, 120.075272);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148892, 120.075275);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148892, 120.075277);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148891, 120.075279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148893, 120.075279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148896, 120.075279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1489, 120.075281);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148905, 120.075282);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148908, 120.075284);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148913, 120.075285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148917, 120.075284);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2294.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148917, 120.075281);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2294.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148915, 120.075279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2295.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148909, 120.075278);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2295.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148906, 120.075276);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2296.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148901, 120.075276);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2297 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148891, 120.075277);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2297.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148887, 120.075276);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2298.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148876, 120.075279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2299.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148869, 120.075281);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2299.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14886, 120.075283);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2300.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148852, 120.075285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2301.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148842, 120.075285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2301.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148832, 120.075284);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2302.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148822, 120.075284);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2302.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148809, 120.075286);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2303.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1488, 120.075288);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2303.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148791, 120.075287);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2304.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148786, 120.075285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2304.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148781, 120.075285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2305.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148774, 120.075286);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2306.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148767, 120.075285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2307.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148766, 120.075282);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2307.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148766, 120.075281);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2308.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148766, 120.075279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2309.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148764, 120.075279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2309.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148764, 120.075276);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148768, 120.075275);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2311.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148775, 120.075273);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2312 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148774, 120.075275);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2313 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148777, 120.075272);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2314 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148779, 120.075268);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2315 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148783, 120.075264);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2316.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148777, 120.075266);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2317 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148779, 120.075262);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2318.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148778, 120.075261);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2319 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148781, 120.07526);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2319.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148785, 120.075259);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2320.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148785, 120.075258);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2321.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148787, 120.075256);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2322.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148793, 120.075255);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2323.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148796, 120.075255);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2325 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148794, 120.07525);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2326.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148791, 120.075248);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2327.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148787, 120.075245);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2328.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148782, 120.075249);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2329.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148776, 120.075254);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2331 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148776, 120.075259);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2333.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148778, 120.075262);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2335.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148785, 120.075252);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2338.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148769, 120.075248);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2340.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14875, 120.075254);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2342.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148749, 120.075252);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2344.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148752, 120.075251);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2347.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148752, 120.075251);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2349.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148744, 120.075252);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2350.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148744, 120.075252);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2352.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14874, 120.075254);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2354.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148737, 120.075257);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2355.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148734, 120.07526);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2357.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148728, 120.075261);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2358.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148723, 120.075261);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2360.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148721, 120.075263);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2362 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148717, 120.075265);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2363.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148715, 120.075267);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2364.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148713, 120.075271);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2366.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148709, 120.075279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2367.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148706, 120.075285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2368.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148706, 120.075294);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2370 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148703, 120.075302);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2371.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1487, 120.07531);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2372.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1487, 120.075321);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2374.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148702, 120.075328);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2375.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148699, 120.075332);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2377.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148695, 120.075336);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2378.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148698, 120.075339);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2379.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148695, 120.075342);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2380.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148691, 120.075345);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2382 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148688, 120.075349);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2383.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148688, 120.075356);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2384.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148689, 120.075364);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2385.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14869, 120.075371);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2386.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148693, 120.075378);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2387.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148697, 120.075385);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2388.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148703, 120.075393);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2389.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148707, 120.075403);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2390.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148706, 120.075415);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2391.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148706, 120.075426);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2393.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148704, 120.075437);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2394.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148704, 120.075449);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2395.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148704, 120.075463);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2396.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148706, 120.07548);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2397.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148705, 120.0755);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2398.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148703, 120.075521);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2399.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148705, 120.075543);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2400.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148712, 120.075566);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2401.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148711, 120.075586);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2402.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148709, 120.075603);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2402.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14871, 120.07562);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2403.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148715, 120.075638);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2404.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148719, 120.075657);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2405 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14872, 120.075675);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2405.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148724, 120.075696);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2406.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148728, 120.075714);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2406.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148732, 120.075734);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2407.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148738, 120.075756);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2407.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148747, 120.075774);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2408.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148758, 120.07579);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2409.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148778, 120.075809);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2409.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148794, 120.075828);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2410.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148807, 120.075847);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2411 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148814, 120.075867);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2411.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14882, 120.075884);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2412 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148826, 120.075906);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2412.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148841, 120.075935);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2413.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148848, 120.075964);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2414.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148856, 120.075987);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2414.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148863, 120.07601);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2415.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148866, 120.07603);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2416.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148864, 120.076045);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2417.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148868, 120.07606);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2418.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148874, 120.076077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2419.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148879, 120.076092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2419.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148889, 120.076107);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2420.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1489, 120.07612);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2421.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148908, 120.076135);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2422.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148912, 120.076149);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2422.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14892, 120.076164);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2423.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148936, 120.076174);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2423.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148948, 120.076186);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2424.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148957, 120.076204);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2424.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148972, 120.076227);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2425.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148981, 120.07625);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2426.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149001, 120.07627);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2426.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149006, 120.076289);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2427.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149004, 120.076303);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2427.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149003, 120.076313);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2428.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149003, 120.076323);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2428.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149008, 120.076338);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2428.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149011, 120.076355);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2429 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149024, 120.076376);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2429.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149038, 120.076402);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149047, 120.076429);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149047, 120.076458);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149053, 120.076488);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149075, 120.076516);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149085, 120.076547);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149092, 120.076577);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149095, 120.076607);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149105, 120.076635);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2432.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149114, 120.076662);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2432.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149121, 120.076691);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149117, 120.076726);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149112, 120.076757);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149123, 120.076793);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149137, 120.076824);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149141, 120.076856);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149142, 120.076884);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149146, 120.076912);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149145, 120.076937);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14915, 120.076962);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149158, 120.076988);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149161, 120.077012);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149162, 120.077037);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149166, 120.077058);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149172, 120.07708);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149182, 120.077101);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149191, 120.077122);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149199, 120.077141);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149208, 120.077161);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149217, 120.077181);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149231, 120.077203);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149242, 120.077227);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149253, 120.077251);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149261, 120.077274);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149271, 120.077299);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2431.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149286, 120.077319);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149309, 120.077337);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149327, 120.077353);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149342, 120.077371);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149355, 120.077393);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149374, 120.077413);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149392, 120.077431);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149398, 120.077455);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149415, 120.077484);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149429, 120.077514);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2430 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149455, 120.077534);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2429.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149472, 120.077559);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2429.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149481, 120.077591);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2429.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149494, 120.07762);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2429.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149502, 120.07765);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2429 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149516, 120.07767);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2428.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149534, 120.077691);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2428.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14955, 120.077718);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2428.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149573, 120.077742);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2427.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14959, 120.077768);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2427.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149607, 120.077795);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2427.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149622, 120.077823);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2426.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149642, 120.077842);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2426.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149664, 120.077859);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2426 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149689, 120.077874);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2425.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149712, 120.077894);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2425.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149726, 120.077915);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2425.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149734, 120.07794);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2425 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149744, 120.077965);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2424.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149768, 120.077988);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2424 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149791, 120.078009);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2423.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149803, 120.078036);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2423.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14981, 120.078076);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2422.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149817, 120.078115);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2422.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149836, 120.078141);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2421.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149867, 120.078165);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2421.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149894, 120.07819);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2420.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149903, 120.07822);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2419.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149912, 120.078254);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2419.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149929, 120.078281);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2418.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149946, 120.078308);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2417.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149955, 120.078337);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2417.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149958, 120.078366);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2416.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149968, 120.078389);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2416 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14998, 120.078415);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2414.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149986, 120.078443);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2413.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149997, 120.078469);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2412.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150006, 120.078494);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2412.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150011, 120.078518);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2411.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150007, 120.078538);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2411.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150008, 120.07856);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2410.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150012, 120.078578);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2409.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150029, 120.078585);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2409 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150041, 120.078603);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2408.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150064, 120.078625);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2407.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150077, 120.078651);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2407 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150083, 120.078676);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2406 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150074, 120.078703);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2405.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150066, 120.078732);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2404.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150068, 120.07876);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2403.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150078, 120.078778);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2402.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150102, 120.0788);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2401.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150124, 120.078822);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2400.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150136, 120.078851);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2399.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150145, 120.078883);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2398.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150153, 120.078919);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2397.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15016, 120.078954);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2396.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150166, 120.078984);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2396 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150191, 120.078997);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2395 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150217, 120.079007);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2394 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150245, 120.079019);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2393 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150264, 120.079046);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2392.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150281, 120.079077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2391.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1503, 120.0791);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2390.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150314, 120.079109);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2389.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150361, 120.079119);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2388.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150384, 120.079141);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2387.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150407, 120.079165);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2386 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150437, 120.079177);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2384.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150466, 120.07918);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2383.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150493, 120.079181);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2382.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150517, 120.07917);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2381.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150537, 120.079174);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2380.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150569, 120.079177);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2379.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150592, 120.079178);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2378.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15062, 120.079171);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2377.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150645, 120.079164);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2376.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150677, 120.079164);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2376.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150703, 120.079157);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2375.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150725, 120.079146);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2374.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150752, 120.079128);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2372.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150767, 120.079124);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2371.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150805, 120.079125);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2371.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150833, 120.079124);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2370.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150849, 120.079112);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2369.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15087, 120.079095);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2367.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150913, 120.079058);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2364.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150957, 120.079031);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2362.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150983, 120.079032);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2361.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151008, 120.079039);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2360.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15103, 120.07904);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2358.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151046, 120.079032);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2357.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151057, 120.079021);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2357 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151069, 120.079006);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2356.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151088, 120.078992);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2354 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151124, 120.078967);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2352.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151154, 120.078959);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2350.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151162, 120.07897);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2349.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15118, 120.07898);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2348.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151196, 120.078985);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2347.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151218, 120.078979);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2346.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151238, 120.07897);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2346.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151255, 120.078967);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2345.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151266, 120.078972);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2344.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1513, 120.078984);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2343.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151323, 120.078987);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2343.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15135, 120.07898);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2342 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151376, 120.07897);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2340.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151405, 120.07896);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2339.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151431, 120.078949);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2335.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151476, 120.078917);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2333.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151507, 120.078911);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2332.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151527, 120.078921);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2330.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151559, 120.078922);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2329.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151588, 120.078914);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2328.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151619, 120.078898);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2327.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151646, 120.078879);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2326.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151672, 120.078862);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2325.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151696, 120.078845);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2324.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151717, 120.078831);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2323.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151732, 120.078822);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2322.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151744, 120.078815);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2321.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151759, 120.078808);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2320.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151786, 120.078788);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2318.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151802, 120.078789);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2317.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15184, 120.078798);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2316.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151865, 120.078798);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2315.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151901, 120.078791);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2314 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151931, 120.078783);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2312.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151965, 120.078772);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2311 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151998, 120.078766);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152024, 120.078766);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2308.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152046, 120.078761);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2307.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152065, 120.078753);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2306.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152086, 120.078743);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2305.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15211, 120.078729);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2304.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152132, 120.078709);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2303.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152157, 120.078684);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2302.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152182, 120.078662);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2301.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152209, 120.07865);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2300.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152236, 120.078639);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2299.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152261, 120.078627);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2298.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152286, 120.078612);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2297.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15231, 120.078595);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2297.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152339, 120.078574);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2296.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15236, 120.078564);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2295.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152381, 120.078562);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2294.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15242, 120.078569);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152443, 120.078568);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2292.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152465, 120.078562);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2291.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152484, 120.07855);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2290.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152507, 120.078536);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2289.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152526, 120.078524);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2288.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152541, 120.07851);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2287.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152557, 120.078497);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2286.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152569, 120.078488);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2285.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152585, 120.078483);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2284.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152602, 120.078479);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2283.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152621, 120.078469);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2282.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152642, 120.07846);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2281.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152665, 120.078451);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2280.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152702, 120.078422);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2279.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152727, 120.078422);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2279 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152746, 120.07843);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2278.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152783, 120.078436);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2277.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152814, 120.078435);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2276.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152842, 120.078419);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2275.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152876, 120.078416);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2274.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152909, 120.078413);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2273.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152955, 120.078414);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2273 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152982, 120.078396);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2272 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153018, 120.078375);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2271.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15305, 120.078353);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2270.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153073, 120.078331);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2269.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153095, 120.078309);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2268.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153117, 120.078287);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2267.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153144, 120.078273);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2266.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153161, 120.078246);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2265.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153164, 120.078215);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2264.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153174, 120.078184);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2263.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153189, 120.078153);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2262.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1532, 120.07813);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2261.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153223, 120.078106);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2260.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153243, 120.078086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2259.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15326, 120.078061);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2259 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153285, 120.078023);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2258.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153325, 120.077985);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2257.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153355, 120.077955);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2256.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15337, 120.077936);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2255.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15339, 120.077914);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2254.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153423, 120.077894);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2253.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153448, 120.077878);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2252.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153472, 120.077852);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2251.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153497, 120.077826);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2250.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153535, 120.077784);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2249 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153579, 120.077736);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2247.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153621, 120.077688);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2246.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153665, 120.077636);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2245.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153709, 120.077592);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2244.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15374, 120.077575);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2243.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153775, 120.077562);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2242.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153805, 120.077547);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2241.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153833, 120.077529);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2240.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153842, 120.07752);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2239.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153857, 120.077507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2238.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153877, 120.077492);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2237.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153873, 120.077484);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2236.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15388, 120.077475);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2236 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153884, 120.077468);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2235.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153895, 120.077458);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2234.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15391, 120.077444);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2233.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153924, 120.07743);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2232.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15394, 120.077419);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2232 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153956, 120.077415);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153976, 120.077414);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154001, 120.077416);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154021, 120.077414);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154038, 120.077406);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2228.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154052, 120.077393);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2227.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154065, 120.077375);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2227.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154077, 120.077357);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2226.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154093, 120.077341);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154105, 120.077333);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154133, 120.077326);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154163, 120.077317);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154189, 120.077313);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2221.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154226, 120.077312);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2220.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154258, 120.077301);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2218.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154305, 120.077279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154338, 120.077276);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2216.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154372, 120.077281);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154416, 120.077279);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154457, 120.07727);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2212.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1545, 120.077259);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2211.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154537, 120.077253);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2210.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154562, 120.077257);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2209.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154593, 120.077256);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2208.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154631, 120.077254);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2206.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154675, 120.07725);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2205.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154705, 120.077251);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2204.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154738, 120.077254);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2203.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154771, 120.077258);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2202.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154802, 120.077257);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2202.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15483, 120.077254);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2201.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154859, 120.077252);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2200.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154887, 120.077254);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2198.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154916, 120.07725);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2197.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154943, 120.077243);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2196.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154971, 120.077236);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2195.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155001, 120.077231);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2194.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155043, 120.077233);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2193.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155073, 120.077229);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2192.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155102, 120.077223);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2191.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155127, 120.077217);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2190.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155144, 120.07721);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2189.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155158, 120.0772);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2189.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155168, 120.077186);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2189.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155179, 120.077168);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2188.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155192, 120.077149);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2186.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155216, 120.077129);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2184.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155244, 120.077111);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2181.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15527, 120.07709);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2180 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1553, 120.077067);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2178.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155338, 120.077043);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2177.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155382, 120.077026);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2176 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155422, 120.077006);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2174.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155458, 120.076994);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2173.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1555, 120.076987);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2172.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155544, 120.076975);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2170.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15559, 120.076962);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2169.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155643, 120.076951);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2167.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15569, 120.076935);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2165.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155737, 120.076918);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2164 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155784, 120.076904);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2162.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155827, 120.076885);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2160.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155868, 120.076859);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2158.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155914, 120.076832);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2156.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15596, 120.07681);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2155.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155999, 120.076789);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2153 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156041, 120.076768);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2151.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156079, 120.076754);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2149.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156128, 120.076744);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2147.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156176, 120.076732);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2146.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156219, 120.076711);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2144.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156256, 120.076684);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2142 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156297, 120.076651);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2140.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156339, 120.076616);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2138.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156388, 120.076586);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2137.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156437, 120.076562);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2135.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156481, 120.076534);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2134.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156535, 120.076508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2137.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156568, 120.07649);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2136.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156611, 120.076461);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2135 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156654, 120.076441);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2133.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156693, 120.076425);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2132.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156728, 120.076405);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2131.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156761, 120.076381);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2130.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156779, 120.076362);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2129.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156781, 120.076347);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2127.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156787, 120.076334);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2126.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156797, 120.076322);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2125.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156806, 120.07631);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2124.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156812, 120.076297);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2123.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156822, 120.076283);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2122.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156831, 120.076266);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2122.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156842, 120.07625);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2121.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156855, 120.076228);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2120.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156872, 120.076205);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2119.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156889, 120.076192);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2119 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156913, 120.076184);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2118 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156928, 120.076173);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2117.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156951, 120.076147);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2116.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156972, 120.076117);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2115.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156993, 120.076089);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2115.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157025, 120.076063);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2114.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157053, 120.076034);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2113.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157079, 120.07601);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2112.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157119, 120.075992);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2111.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157152, 120.07597);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2110.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157185, 120.075946);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2109.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157223, 120.075927);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2108.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157262, 120.075918);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2107.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157307, 120.075909);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2106.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157351, 120.075898);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2105 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157398, 120.075892);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2104 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157437, 120.075881);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2102.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157481, 120.075868);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2101.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15753, 120.075852);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2100.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157568, 120.07583);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2099.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157602, 120.075801);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2098.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157638, 120.075778);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2097 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15768, 120.07576);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2095.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15772, 120.075746);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2094.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157752, 120.075726);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2093.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157786, 120.075691);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2091.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157821, 120.075651);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2090.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157854, 120.075608);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2089.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157884, 120.075561);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2088.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157907, 120.075511);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2087.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15792, 120.075461);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2085.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157937, 120.075415);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2084.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15796, 120.07538);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2083.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15798, 120.075349);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2082.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157997, 120.075324);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2081 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158011, 120.075305);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2080 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158027, 120.075288);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2078.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158046, 120.075272);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2077.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158058, 120.075258);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2076.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158065, 120.075243);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2075.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158073, 120.075236);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2074.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158082, 120.075225);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2074 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158088, 120.075215);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2073.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158094, 120.07521);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2072.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158102, 120.075205);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2071.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158109, 120.075201);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2070.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158113, 120.075193);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2069.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158121, 120.075182);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2068.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15813, 120.075177);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2067.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158137, 120.075174);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2066.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158146, 120.075172);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158153, 120.075165);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158163, 120.075156);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2064.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15817, 120.075149);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2063.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158174, 120.075136);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2062.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158182, 120.075122);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2062.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158191, 120.075107);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2061.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158201, 120.0751);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2060.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158209, 120.07511);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2059.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158216, 120.075117);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2059.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158222, 120.075114);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2058.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158229, 120.075108);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2058.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158242, 120.075094);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2057.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158251, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2057.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158254, 120.075073);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2056.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158259, 120.075068);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2056.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158262, 120.075059);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2056 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15827, 120.075052);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2055.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158272, 120.075039);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2055.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158276, 120.075029);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2055.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158283, 120.075013);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2055.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158288, 120.075004);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2055.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158292, 120.074996);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2055.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158294, 120.074988);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2054.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158288, 120.074998);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2054.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158286, 120.075007);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2054.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158282, 120.075016);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2054.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158275, 120.075027);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2054.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158271, 120.075034);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2053.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158261, 120.075034);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2053.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158255, 120.075038);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2053.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158251, 120.075047);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2053.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158244, 120.075058);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2052.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158239, 120.075074);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2052.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158246, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2052.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158252, 120.075083);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2052.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15825, 120.075097);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2052.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158247, 120.075104);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2053 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158245, 120.075113);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2053.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158236, 120.075122);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2053.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158227, 120.07513);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2054.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158232, 120.075138);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2055.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158233, 120.075145);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2056.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158236, 120.075148);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2057.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158234, 120.075153);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2058.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158235, 120.075157);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2059 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15824, 120.075159);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2059.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158237, 120.075165);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2059.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158238, 120.07517);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2060.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158238, 120.075176);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2060.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158235, 120.075181);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2060.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158226, 120.075185);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2061.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158208, 120.075187);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2061.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158196, 120.07519);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2062.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158192, 120.075191);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2062.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158179, 120.075191);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2063.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158171, 120.075196);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2063.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158163, 120.075197);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2064.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158159, 120.075192);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2064.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158158, 120.075193);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2064.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158157, 120.075194);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2064.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158156, 120.075195);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158154, 120.075196);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158152, 120.075197);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158152, 120.075197);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158152, 120.075197);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158152, 120.075196);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158151, 120.075195);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158147, 120.075194);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158143, 120.075195);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158138, 120.075196);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158134, 120.075198);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158129, 120.0752);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158124, 120.075201);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158119, 120.075201);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158115, 120.075203);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158112, 120.075204);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158109, 120.075205);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158108, 120.075207);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158107, 120.075211);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158108, 120.075217);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2066 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158108, 120.075222);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2066 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158105, 120.075223);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158069, 120.075201);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158063, 120.075196);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158054, 120.075187);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157996, 120.075156);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157969, 120.075147);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157915, 120.07515);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15789, 120.075148);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157894, 120.075134);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157868, 120.075134);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2065.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157847, 120.07513);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2066 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157824, 120.075128);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2066.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157796, 120.075124);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2066.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15777, 120.075118);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2066.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157743, 120.075113);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2067 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157716, 120.07511);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2067.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157677, 120.07511);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2067.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157636, 120.075114);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2068.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157613, 120.075113);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2068.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157585, 120.075112);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2069.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157564, 120.075111);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2069.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157543, 120.075109);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2070.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157525, 120.075106);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2070.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157496, 120.075105);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2071.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157466, 120.075108);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2072.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157432, 120.075108);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2072.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157402, 120.075108);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2073.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157372, 120.075109);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2074.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157344, 120.075109);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2074.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157322, 120.075106);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2075.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157302, 120.075105);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2076.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157275, 120.075107);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2076.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157255, 120.075109);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2077.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157236, 120.075107);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2078 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157214, 120.075103);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2078.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157198, 120.075101);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2079.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157171, 120.0751);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2079.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157153, 120.075101);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2080 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157124, 120.07511);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2080.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157102, 120.075114);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2080.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157076, 120.075115);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2081.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157044, 120.075118);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2081.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157012, 120.075119);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2082 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156987, 120.075121);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2082.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156957, 120.075122);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2083.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156933, 120.07512);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2083.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156898, 120.075121);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2084.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156868, 120.075119);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2084.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156843, 120.075119);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2085.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15682, 120.075121);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2085.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156792, 120.07512);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2086.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156768, 120.075121);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2086.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156744, 120.075121);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2087.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156713, 120.075121);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2088 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156688, 120.07512);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2088.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156671, 120.075118);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2089.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15665, 120.075115);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2090 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156632, 120.075112);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2090.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156611, 120.075107);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2091.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156591, 120.075103);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2092.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156567, 120.075101);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2092.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15654, 120.075098);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2093.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156519, 120.075097);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2094.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156492, 120.075097);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2094.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15646, 120.075099);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2095.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156433, 120.0751);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2096.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156409, 120.075097);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2097.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15639, 120.075094);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2098 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156369, 120.075093);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2098.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156344, 120.075093);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2099.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156323, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2100.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156303, 120.07509);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2101.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156279, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2101.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156254, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2102.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156231, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2103.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156216, 120.07509);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2104.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156218, 120.075087);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2105.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156216, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2105.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156206, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2106.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156194, 120.075073);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2106.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15618, 120.075066);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2107 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15616, 120.075063);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2107.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156138, 120.075062);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2107.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156118, 120.075063);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2107.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156094, 120.075063);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2108.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156066, 120.07506);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2108.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156044, 120.075059);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2108.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156018, 120.075057);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2109.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155993, 120.075055);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2109.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15597, 120.075054);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2110.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155943, 120.075052);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2110.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155911, 120.075052);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2111.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155873, 120.075053);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2112 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155844, 120.075056);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2112.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15582, 120.075056);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2113.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155793, 120.075055);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2114 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15577, 120.075053);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2114.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15574, 120.075051);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2115.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155708, 120.075046);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2116.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155684, 120.075044);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2117.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155657, 120.075041);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2117.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15563, 120.075037);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2118.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155607, 120.075038);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2119.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155582, 120.075039);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2119.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155552, 120.075035);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2120.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155523, 120.075032);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2120.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155491, 120.075032);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2121 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155462, 120.075033);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2121.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155433, 120.075034);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2121.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1554, 120.075037);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2122 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155374, 120.075041);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2122.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155341, 120.075045);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2123 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155311, 120.075049);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2123.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155287, 120.075049);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2123.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155259, 120.075049);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2124.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155235, 120.075048);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2124.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155213, 120.075045);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2124.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155192, 120.075046);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2125.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15517, 120.075043);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2125.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155147, 120.075041);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2126.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155119, 120.075036);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2126.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155109, 120.075037);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2127 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155089, 120.075035);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2127.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155067, 120.075034);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2127.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155047, 120.075035);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2128 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155024, 120.07504);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2128.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154998, 120.075041);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2128.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15497, 120.075041);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2129.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15494, 120.07504);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2129.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154903, 120.07504);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2130.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154872, 120.07504);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2130.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154844, 120.075037);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2130.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154823, 120.075034);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2131 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154787, 120.075034);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2131.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154762, 120.075041);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2132 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15474, 120.075044);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2132.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154715, 120.075046);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2133.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154681, 120.075049);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2133.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15465, 120.075051);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2133.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154618, 120.075051);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2134.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154586, 120.075051);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2134.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154559, 120.075053);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2134.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154535, 120.075053);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2134.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154511, 120.075055);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2135 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154487, 120.075056);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2135.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154459, 120.075057);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2135.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154437, 120.075061);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2135.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154408, 120.075068);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2136 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154381, 120.075072);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2136.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154354, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2136.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154325, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2137 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154297, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2137.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154277, 120.075084);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2137.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154258, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2138.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154232, 120.075085);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2138.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15421, 120.075085);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2139.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154186, 120.075085);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2139.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154162, 120.075083);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2140.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154135, 120.075084);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2140.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154108, 120.075084);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2141.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154084, 120.075084);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2141.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154056, 120.075085);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2142.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154021, 120.075087);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2143.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153991, 120.075088);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2144 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153961, 120.075089);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2144.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153944, 120.075085);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2145.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153922, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2146.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1539, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2146.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153885, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2147.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153859, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2148.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153834, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2149.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153805, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2149.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153776, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2150.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153764, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2151.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153736, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2152.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153707, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2153.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15368, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2154.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153651, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2154.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153615, 120.075074);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2155.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153585, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2155.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153553, 120.075076);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2156.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153522, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2156.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153487, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2157.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153455, 120.075083);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2158 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153419, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2158.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153381, 120.075088);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2159.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15335, 120.075089);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2159.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153322, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2160.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153293, 120.075092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2160.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153263, 120.075094);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2161.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15323, 120.075096);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2161.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153203, 120.075097);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2162.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153176, 120.075098);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2162.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153153, 120.075097);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2163.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153133, 120.075095);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2164.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153111, 120.075093);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2164.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153088, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2165.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153065, 120.075089);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2166 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153046, 120.075088);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2166.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153024, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2167.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152998, 120.075083);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2167.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152976, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2168.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152957, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2168.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152935, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2169.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152913, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2169.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152886, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2170.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152862, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2171.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152838, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2171.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152817, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2172.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152799, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2173.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152783, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2173.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152767, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2174.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152752, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2175.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152738, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2176.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152724, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2177 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15271, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2177.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152694, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2178.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152679, 120.075074);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2178.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152657, 120.075071);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2179.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152632, 120.075072);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2180 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152608, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2180.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152578, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2181.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152548, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2182.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152521, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2182.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152498, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2183.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152474, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2184.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152444, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2185 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152415, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2185.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152393, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2186.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152362, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2187.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152334, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2188.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152305, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2189.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152275, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2190.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152256, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2191.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152234, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2192.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152206, 120.075074);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2192.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152187, 120.075072);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2193.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152169, 120.07507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2194.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152156, 120.075067);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2194.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152135, 120.075063);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2195.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152109, 120.075063);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2195.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15209, 120.075061);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2196.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152068, 120.07506);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2196.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152046, 120.075059);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2197.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152028, 120.075059);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2197.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152008, 120.075061);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2198.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151983, 120.075061);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2198.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151953, 120.075063);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2198.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151926, 120.075066);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2199.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151898, 120.07507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2199.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151877, 120.07507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2200.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151857, 120.07507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2200.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151836, 120.075068);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2201.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151813, 120.075068);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2201.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151787, 120.075069);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2202.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151767, 120.075069);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2202.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151745, 120.075069);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2203.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151722, 120.075069);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2204 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151712, 120.075067);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2204.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151708, 120.075065);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2204.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151695, 120.075064);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2205.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151681, 120.075064);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2205.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151663, 120.075064);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2205.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15164, 120.075065);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2205.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151615, 120.075067);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2206.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151592, 120.075068);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2206.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151568, 120.075071);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2206.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151539, 120.075068);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2207 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151518, 120.075064);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2207.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151487, 120.075062);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2207.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151457, 120.075062);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2208.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151429, 120.075062);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2208.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151404, 120.075063);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2209.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151385, 120.075064);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2210 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151364, 120.075066);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2210.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151349, 120.075069);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2211.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151341, 120.075072);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2211.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151328, 120.075076);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2212.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151307, 120.075076);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2212.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151275, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2212.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151262, 120.075073);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2213.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151239, 120.075073);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2213.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151226, 120.075073);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2213.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151201, 120.075074);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2213.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151179, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151156, 120.075076);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151136, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151114, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151085, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151055, 120.075072);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151018, 120.075071);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150982, 120.075074);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150946, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150909, 120.075076);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2216.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150871, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2216.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150835, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1508, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150763, 120.075083);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2218.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150733, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2218.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150704, 120.075084);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2219.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150678, 120.075088);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2219.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150651, 120.07509);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2220.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15062, 120.075092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2220.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150584, 120.075094);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2220.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150554, 120.075096);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2221.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150522, 120.075096);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2221.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150496, 120.075095);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150474, 120.075093);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150449, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150421, 120.075089);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150396, 120.075089);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150369, 120.07509);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150338, 120.07509);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150309, 120.07509);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150277, 120.07509);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150242, 120.075092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150208, 120.075093);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150177, 120.075093);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150153, 120.075092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150123, 120.075092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2226 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150091, 120.075092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2226.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150065, 120.07509);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2226.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150042, 120.075088);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150022, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149966, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149935, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149912, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149888, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149868, 120.075073);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149849, 120.075072);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149842, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149837, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149826, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149808, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149781, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149755, 120.075081);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149724, 120.075082);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149693, 120.075084);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149663, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149632, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2224 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149597, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149562, 120.075088);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149525, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149493, 120.075092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149464, 120.075091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149441, 120.075089);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149423, 120.075086);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149407, 120.075083);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149392, 120.07508);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149372, 120.075078);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2221.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149355, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2221.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149338, 120.075076);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2221.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149321, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2220.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149304, 120.075074);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2220.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149286, 120.07507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2220.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14926, 120.07507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2219.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149236, 120.075069);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2219.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149215, 120.07507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2218.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149197, 120.075074);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2218.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149177, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149158, 120.075079);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149138, 120.075075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2216.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149116, 120.075077);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149085, 120.075087);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149067, 120.075092);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149041, 120.075105);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148993, 120.075134);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148962, 120.075145);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148972, 120.075163);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148973, 120.075183);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148964, 120.075201);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148962, 120.075218);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2219.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148981, 120.075232);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14901, 120.075238);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149025, 120.075242);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2227.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149049, 120.075242);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2228.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149042, 120.075238);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2228.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149039, 120.075246);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149035, 120.075255);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14904, 120.075266);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149039, 120.075274);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149033, 120.075281);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149027, 120.075283);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149025, 120.075285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149023, 120.075287);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149022, 120.075291);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149022, 120.075291);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149022, 120.075291);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149022, 120.075291);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149022, 120.075291);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149022, 120.075291);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149021, 120.075292);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075293);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075293);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075293);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075293);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075293);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14902, 120.075293);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149021, 120.075295);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149021, 120.075298);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14902, 120.075303);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149017, 120.075308);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2229.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149016, 120.075313);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149015, 120.075317);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149015, 120.075321);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149015, 120.075323);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149016, 120.075326);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.07533);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.07533);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075333);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149018, 120.075337);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149017, 120.07534);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149016, 120.075342);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149016, 120.075344);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149017, 120.075347);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149018, 120.075348);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075349);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075349);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075352);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075352);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149018, 120.075355);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149018, 120.075355);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149019, 120.075362);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14901, 120.075363);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2233.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148986, 120.075348);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2235.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148974, 120.075341);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2236.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148961, 120.075337);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2237.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148954, 120.075337);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2239.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148948, 120.075337);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2241.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148942, 120.075341);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2244.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148936, 120.075349);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2246.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14893, 120.075356);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2248.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148928, 120.075367);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2250.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148926, 120.075378);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2252.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14892, 120.07539);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2254.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148917, 120.075404);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2256.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148912, 120.075418);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2257.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148911, 120.075427);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2259.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148909, 120.075437);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2260.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148907, 120.075446);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2261.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148905, 120.075455);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2263.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148901, 120.075474);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2264.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148899, 120.075489);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2266.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148897, 120.075502);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2268.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148899, 120.075524);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2269.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148899, 120.075546);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2270.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148901, 120.075568);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2271.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148906, 120.075586);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2271.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148912, 120.075611);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2272.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148917, 120.075637);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2274 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148923, 120.075664);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2275.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148933, 120.075697);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2276.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148943, 120.075726);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2277.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148951, 120.075752);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2278.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148961, 120.07578);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2280.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148959, 120.075802);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2286.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148936, 120.075832);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2289.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148935, 120.075853);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148932, 120.075884);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2295.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148928, 120.075925);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2298.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148919, 120.075977);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2301.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148918, 120.076002);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2303.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148928, 120.076027);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2305.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148939, 120.076059);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2307 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148953, 120.076098);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2308.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148967, 120.076134);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2309.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148982, 120.076166);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2309.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148993, 120.076204);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2309.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.148999, 120.076249);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149002, 120.07631);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149012, 120.076368);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14902, 120.076431);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2311.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149027, 120.076503);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149026, 120.076575);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2311.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149037, 120.076641);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149052, 120.076701);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149065, 120.076756);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149081, 120.076815);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1491, 120.076865);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2311.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149109, 120.076938);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149124, 120.076993);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2310.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149151, 120.07704);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2309.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149169, 120.077091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2309 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149185, 120.077129);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2308.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14921, 120.07717);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2307.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149253, 120.077222);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2306.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14928, 120.077285);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2305.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149339, 120.07734);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2305 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149375, 120.077402);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2304.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149407, 120.07746);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2303.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14947, 120.077517);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2302.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149512, 120.077573);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2301.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149557, 120.077629);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2299.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149602, 120.077687);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2298.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149638, 120.07775);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2297.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149679, 120.077813);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2296.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149717, 120.077876);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2295 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149747, 120.077941);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149773, 120.078006);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2292.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149788, 120.078072);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2291.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14981, 120.07815);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2291.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149825, 120.078223);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2294.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149856, 120.078286);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2294 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149877, 120.078359);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2293.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149901, 120.078419);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2292.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14992, 120.078465);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2291.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.14996, 120.078512);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2290.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.149991, 120.078559);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2289.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150018, 120.078601);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2287.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150089, 120.078632);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2286.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150135, 120.078664);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2284.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150173, 120.078704);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2283.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150208, 120.078745);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2285.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150239, 120.078774);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2284.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150248, 120.078789);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2283.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150275, 120.078807);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2282.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150312, 120.07882);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2283.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150319, 120.078906);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2283.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150335, 120.078892);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2282.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150369, 120.07889);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2281.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150398, 120.078908);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2281.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150436, 120.078913);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2280 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150477, 120.078896);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2279 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150509, 120.07887);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2278 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150533, 120.078868);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2276.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150575, 120.078864);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2275.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150603, 120.078839);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2274.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150645, 120.078832);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2273.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150681, 120.078829);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2271.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150719, 120.078825);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2270.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150755, 120.078813);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2268.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150789, 120.078803);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2267.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150841, 120.078795);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2265.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150892, 120.078782);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2264.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150936, 120.078767);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2262.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.150982, 120.078751);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2260.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15105, 120.078734);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2258.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151105, 120.078717);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2257.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151164, 120.078703);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2255.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15123, 120.078689);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2253.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151284, 120.078668);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2252 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151337, 120.078638);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2250.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151396, 120.078599);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2248.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151453, 120.078559);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2252.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151483, 120.078532);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2251.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15153, 120.078505);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2250.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151585, 120.078474);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2249 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151638, 120.078436);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2247.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151688, 120.078403);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2246.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151742, 120.078374);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2245.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151804, 120.078348);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2244.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151857, 120.078332);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2243.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151925, 120.078319);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2241.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.151978, 120.078299);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2240.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152019, 120.078286);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2239.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152083, 120.078272);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2238.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152148, 120.078258);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2237 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152209, 120.078249);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2235.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152247, 120.078229);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2234.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152303, 120.078206);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2233.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152362, 120.078175);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2232.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152419, 120.078136);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2231.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152477, 120.078091);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2230 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152531, 120.078039);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2228.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152585, 120.077981);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2227.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152633, 120.077913);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2226.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152686, 120.077856);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2225.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152745, 120.077822);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2223.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152797, 120.077787);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2222.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152817, 120.077744);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2221.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152862, 120.077699);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2219.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152912, 120.077658);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2218.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.152962, 120.077618);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2217.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153018, 120.077574);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2215.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153078, 120.077534);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2214.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153133, 120.077499);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2213 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15319, 120.077465);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2211.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153239, 120.077433);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2210.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153286, 120.077406);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2209.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153341, 120.077377);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2207.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153394, 120.077336);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2206.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153446, 120.077287);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2205.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153489, 120.077248);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2205.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153527, 120.077212);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2204.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153576, 120.077182);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2203.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153606, 120.077165);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2202.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153652, 120.077148);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2201.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153702, 120.077132);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2200.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15376, 120.07713);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2199.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153831, 120.077128);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2198.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153911, 120.077122);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2197.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.153985, 120.077108);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2196.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15406, 120.07709);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2195.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154117, 120.077075);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2194.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154177, 120.077062);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2193.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154238, 120.077047);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2192.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154286, 120.077032);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2191.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154338, 120.077014);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2189.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154391, 120.07699);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2188.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154446, 120.076962);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2187.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154497, 120.076929);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2186.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154556, 120.076897);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2185.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154617, 120.076868);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2183.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154674, 120.07684);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2182.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15474, 120.07681);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2181.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154801, 120.076775);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2180.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154856, 120.076744);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2178.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154911, 120.076712);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2177.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.154968, 120.076678);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2176.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155025, 120.07665);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2175.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155085, 120.076623);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2173.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155142, 120.076598);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2172.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155203, 120.076579);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2171.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155258, 120.076551);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2169.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15531, 120.076518);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2168.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155366, 120.076487);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2167.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155422, 120.07646);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2165.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155479, 120.076448);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2164.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15553, 120.076438);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2163.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155594, 120.076429);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2161.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15566, 120.076418);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2160.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155727, 120.076409);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2159.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155788, 120.0764);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2158.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155846, 120.07638);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2156.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155897, 120.076349);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2155.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.155952, 120.076318);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2154.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156011, 120.076281);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2152.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15606, 120.076241);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2151.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156097, 120.076203);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2150.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156141, 120.076172);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2149.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156191, 120.076142);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2149.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156236, 120.076108);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2148.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156278, 120.076072);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2147.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156314, 120.076039);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2146.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156355, 120.076017);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2145 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156393, 120.075996);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2143.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156448, 120.075975);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2142.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156504, 120.075951);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2141.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156551, 120.075923);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2139.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156615, 120.075895);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2138.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156673, 120.075867);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2137.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156724, 120.075839);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2135.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15678, 120.075809);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2134.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156843, 120.07579);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2133 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156905, 120.075775);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2131.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.156961, 120.075763);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2130.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157009, 120.075748);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2129.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157066, 120.075725);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2128.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157104, 120.075702);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2127.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157142, 120.075685);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2126.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157184, 120.075668);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2125 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15722, 120.075647);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2123.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157259, 120.075623);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2122.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157291, 120.075598);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2121.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157337, 120.075577);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2120.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157378, 120.075553);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2119.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157429, 120.075526);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2118.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157505, 120.075507);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2117.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157562, 120.075513);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2117.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157667, 120.075524);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2116.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15777, 120.075543);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2116 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157851, 120.075568);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2114.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157901, 120.075591);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2113.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15795, 120.075614);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2113.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.157993, 120.075633);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2112.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158039, 120.07565);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2112 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158083, 120.075671);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2111.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158118, 120.07569);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2111.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158144, 120.075706);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2110.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158159, 120.075716);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2110.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158177, 120.075723);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2110 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158198, 120.075729);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2109.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158215, 120.07573);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2109.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158249, 120.075737);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2109 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158269, 120.075742);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2108.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158289, 120.075746);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2108.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158305, 120.075753);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2108.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158311, 120.075758);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2109 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158317, 120.075766);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2109.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158313, 120.075768);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2110.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158314, 120.075767);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2111.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158319, 120.075765);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2112.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158317, 120.075762);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2113.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158326, 120.075762);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2114 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158333, 120.075764);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2114.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158346, 120.075768);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2115.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158336, 120.075767);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2116.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158335, 120.075768);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2117 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158336, 120.07577);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2117.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15832, 120.075767);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2118.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158315, 120.075766);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2118.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158309, 120.07576);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2119.2 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.1583, 120.075753);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2119.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158296, 120.075753);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2120.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158293, 120.075754);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2121.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158289, 120.075756);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2122 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158285, 120.075759);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2122.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158282, 120.075761);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2123.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158278, 120.075763);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2124.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158274, 120.075767);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2124.9 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158262, 120.075767);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2125.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158244, 120.075766);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2126.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158229, 120.075756);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2126.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158213, 120.075743);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2127.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158196, 120.075724);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2128 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158176, 120.075705);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2128.4 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.15816, 120.075692);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2128.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158143, 120.075678);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2129.1 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158128, 120.075663);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2129.5 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158112, 120.075651);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2130.6 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158098, 120.075636);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2131.7 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158087, 120.07562);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2132.8 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158078, 120.075609);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2133 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  loc = CLLocationCoordinate2DMake(39.158076, 120.07561);
  location = [[CLLocation alloc] initWithCoordinate:loc altitude:2133.3 horizontalAccuracy:0 verticalAccuracy:0 course:111 speed:111 timestamp:time];
  [artrailpoint_array addObject:location];
  
  
//  CLLocation *this_location;
//  for(int i = 0; i < [artrailpoint_array count]; i++){
//    this_location = [artrailpoint_array objectAtIndex:i];
//    NSLog(@"JERRY:point altitude=>%f longtitude =>%f", this_location.altitude, this_location.coordinate.longitude);
//  }
  return artrailpoint_array;
}
@end
