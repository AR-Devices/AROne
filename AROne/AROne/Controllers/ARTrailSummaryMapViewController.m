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
  NSArray *my_trail_data = [[NSArray alloc] initWithObjects:
                                      [[NSArray alloc] initWithObjects:@"2292.9", @"3914.8894", @"12007.5267", nil],
                                      [[NSArray alloc] initWithObjects:@"2293", @"3914.8894", @"12007.5269", nil],
                                      [[NSArray alloc] initWithObjects:@"2293", @"3914.8893", @"12007.5272", nil],
                                      [[NSArray alloc] initWithObjects:@"2293", @"3914.8892", @"12007.5275", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.1", @"3914.8892", @"12007.5277", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.1", @"3914.8891", @"12007.5279", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.2", @"3914.8893", @"12007.5279", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.3", @"3914.8896", @"12007.5279", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.4", @"3914.89", @"12007.5281", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.5", @"3914.8905", @"12007.5282", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.6", @"3914.8908", @"12007.5284", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.8", @"3914.8913", @"12007.5285", nil],
                                      [[NSArray alloc] initWithObjects:@"2294.2", @"3914.8917", @"12007.5284", nil],
                                      [[NSArray alloc] initWithObjects:@"2294.7", @"3914.8917", @"12007.5281", nil],
                                      [[NSArray alloc] initWithObjects:@"2295.3", @"3914.8915", @"12007.5279", nil],
                                      [[NSArray alloc] initWithObjects:@"2295.7", @"3914.8909", @"12007.5278", nil],
                                      [[NSArray alloc] initWithObjects:@"2296.3", @"3914.8906", @"12007.5276", nil],
                                      [[NSArray alloc] initWithObjects:@"2297", @"3914.8901", @"12007.5276", nil],
                                      [[NSArray alloc] initWithObjects:@"2297.7", @"3914.8891", @"12007.5277", nil],
                                      [[NSArray alloc] initWithObjects:@"2298.4", @"3914.8887", @"12007.5276", nil],
                                      [[NSArray alloc] initWithObjects:@"2299.1", @"3914.8876", @"12007.5279", nil],
                                      [[NSArray alloc] initWithObjects:@"2299.8", @"3914.8869", @"12007.5281", nil],
                                      [[NSArray alloc] initWithObjects:@"2300.4", @"3914.886", @"12007.5283", nil],
                                      [[NSArray alloc] initWithObjects:@"2301.1", @"3914.8852", @"12007.5285", nil],
                                      [[NSArray alloc] initWithObjects:@"2301.7", @"3914.8842", @"12007.5285", nil],
                                      [[NSArray alloc] initWithObjects:@"2302.2", @"3914.8832", @"12007.5284", nil],
                                      [[NSArray alloc] initWithObjects:@"2302.6", @"3914.8822", @"12007.5284", nil],
                                      [[NSArray alloc] initWithObjects:@"2303.1", @"3914.8809", @"12007.5286", nil],
                                      [[NSArray alloc] initWithObjects:@"2303.7", @"3914.88", @"12007.5288", nil],
                                      [[NSArray alloc] initWithObjects:@"2304.4", @"3914.8791", @"12007.5287", nil],
                                      [[NSArray alloc] initWithObjects:@"2304.9", @"3914.8786", @"12007.5285", nil],
                                      [[NSArray alloc] initWithObjects:@"2305.6", @"3914.8781", @"12007.5285", nil],
                                      [[NSArray alloc] initWithObjects:@"2306.3", @"3914.8774", @"12007.5286", nil],
                                      [[NSArray alloc] initWithObjects:@"2307.1", @"3914.8767", @"12007.5285", nil],
                                      [[NSArray alloc] initWithObjects:@"2307.7", @"3914.8766", @"12007.5282", nil],
                                      [[NSArray alloc] initWithObjects:@"2308.3", @"3914.8766", @"12007.5281", nil],
                                      [[NSArray alloc] initWithObjects:@"2309.1", @"3914.8766", @"12007.5279", nil],
                                      [[NSArray alloc] initWithObjects:@"2309.9", @"3914.8764", @"12007.5279", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.6", @"3914.8764", @"12007.5276", nil],
                                      [[NSArray alloc] initWithObjects:@"2311.3", @"3914.8768", @"12007.5275", nil],
                                      [[NSArray alloc] initWithObjects:@"2312", @"3914.8775", @"12007.5273", nil],
                                      [[NSArray alloc] initWithObjects:@"2313", @"3914.8774", @"12007.5275", nil],
                                      [[NSArray alloc] initWithObjects:@"2314", @"3914.8777", @"12007.5272", nil],
                                      [[NSArray alloc] initWithObjects:@"2315", @"3914.8779", @"12007.5268", nil],
                                      [[NSArray alloc] initWithObjects:@"2316.1", @"3914.8783", @"12007.5264", nil],
                                      [[NSArray alloc] initWithObjects:@"2317", @"3914.8777", @"12007.5266", nil],
                                      [[NSArray alloc] initWithObjects:@"2318.1", @"3914.8779", @"12007.5262", nil],
                                      [[NSArray alloc] initWithObjects:@"2319", @"3914.8778", @"12007.5261", nil],
                                      [[NSArray alloc] initWithObjects:@"2319.9", @"3914.8781", @"12007.526", nil],
                                      [[NSArray alloc] initWithObjects:@"2320.9", @"3914.8785", @"12007.5259", nil],
                                      [[NSArray alloc] initWithObjects:@"2321.9", @"3914.8785", @"12007.5258", nil],
                                      [[NSArray alloc] initWithObjects:@"2322.8", @"3914.8787", @"12007.5256", nil],
                                      [[NSArray alloc] initWithObjects:@"2323.8", @"3914.8793", @"12007.5255", nil],
                                      [[NSArray alloc] initWithObjects:@"2325", @"3914.8796", @"12007.5255", nil],
                                      [[NSArray alloc] initWithObjects:@"2326.1", @"3914.8794", @"12007.525", nil],
                                      [[NSArray alloc] initWithObjects:@"2327.2", @"3914.8791", @"12007.5248", nil],
                                      [[NSArray alloc] initWithObjects:@"2328.4", @"3914.8787", @"12007.5245", nil],
                                      [[NSArray alloc] initWithObjects:@"2329.8", @"3914.8782", @"12007.5249", nil],
                                      [[NSArray alloc] initWithObjects:@"2331", @"3914.8776", @"12007.5254", nil],
                                      [[NSArray alloc] initWithObjects:@"2333.5", @"3914.8776", @"12007.5259", nil],
                                      [[NSArray alloc] initWithObjects:@"2335.9", @"3914.8778", @"12007.5262", nil],
                                      [[NSArray alloc] initWithObjects:@"2338.1", @"3914.8785", @"12007.5252", nil],
                                      [[NSArray alloc] initWithObjects:@"2340.1", @"3914.8769", @"12007.5248", nil],
                                      [[NSArray alloc] initWithObjects:@"2342.9", @"3914.875", @"12007.5254", nil],
                                      [[NSArray alloc] initWithObjects:@"2344.7", @"3914.8749", @"12007.5252", nil],
                                      [[NSArray alloc] initWithObjects:@"2347.5", @"3914.8752", @"12007.5251", nil],
                                      [[NSArray alloc] initWithObjects:@"2349.2", @"3914.8752", @"12007.5251", nil],
                                      [[NSArray alloc] initWithObjects:@"2350.8", @"3914.8744", @"12007.5252", nil],
                                      [[NSArray alloc] initWithObjects:@"2352.5", @"3914.8744", @"12007.5252", nil],
                                      [[NSArray alloc] initWithObjects:@"2354.2", @"3914.874", @"12007.5254", nil],
                                      [[NSArray alloc] initWithObjects:@"2355.7", @"3914.8737", @"12007.5257", nil],
                                      [[NSArray alloc] initWithObjects:@"2357.2", @"3914.8734", @"12007.526", nil],
                                      [[NSArray alloc] initWithObjects:@"2358.7", @"3914.8728", @"12007.5261", nil],
                                      [[NSArray alloc] initWithObjects:@"2360.1", @"3914.8723", @"12007.5261", nil],
                                      [[NSArray alloc] initWithObjects:@"2362", @"3914.8721", @"12007.5263", nil],
                                      [[NSArray alloc] initWithObjects:@"2363.5", @"3914.8717", @"12007.5265", nil],
                                      [[NSArray alloc] initWithObjects:@"2364.8", @"3914.8715", @"12007.5267", nil],
                                      [[NSArray alloc] initWithObjects:@"2366.3", @"3914.8713", @"12007.5271", nil],
                                      [[NSArray alloc] initWithObjects:@"2367.4", @"3914.8709", @"12007.5279", nil],
                                      [[NSArray alloc] initWithObjects:@"2368.7", @"3914.8706", @"12007.5285", nil],
                                      [[NSArray alloc] initWithObjects:@"2370", @"3914.8706", @"12007.5294", nil],
                                      [[NSArray alloc] initWithObjects:@"2371.4", @"3914.8703", @"12007.5302", nil],
                                      [[NSArray alloc] initWithObjects:@"2372.7", @"3914.87", @"12007.531", nil],
                                      [[NSArray alloc] initWithObjects:@"2374.3", @"3914.87", @"12007.5321", nil],
                                      [[NSArray alloc] initWithObjects:@"2375.7", @"3914.8702", @"12007.5328", nil],
                                      [[NSArray alloc] initWithObjects:@"2377.3", @"3914.8699", @"12007.5332", nil],
                                      [[NSArray alloc] initWithObjects:@"2378.8", @"3914.8695", @"12007.5336", nil],
                                      [[NSArray alloc] initWithObjects:@"2379.5", @"3914.8698", @"12007.5339", nil],
                                      [[NSArray alloc] initWithObjects:@"2380.9", @"3914.8695", @"12007.5342", nil],
                                      [[NSArray alloc] initWithObjects:@"2382", @"3914.8691", @"12007.5345", nil],
                                      [[NSArray alloc] initWithObjects:@"2383.3", @"3914.8688", @"12007.5349", nil],
                                      [[NSArray alloc] initWithObjects:@"2384.4", @"3914.8688", @"12007.5356", nil],
                                      [[NSArray alloc] initWithObjects:@"2385.6", @"3914.8689", @"12007.5364", nil],
                                      [[NSArray alloc] initWithObjects:@"2386.6", @"3914.869", @"12007.5371", nil],
                                      [[NSArray alloc] initWithObjects:@"2387.6", @"3914.8693", @"12007.5378", nil],
                                      [[NSArray alloc] initWithObjects:@"2388.5", @"3914.8697", @"12007.5385", nil],
                                      [[NSArray alloc] initWithObjects:@"2389.6", @"3914.8703", @"12007.5393", nil],
                                      [[NSArray alloc] initWithObjects:@"2390.7", @"3914.8707", @"12007.5403", nil],
                                      [[NSArray alloc] initWithObjects:@"2391.8", @"3914.8706", @"12007.5415", nil],
                                      [[NSArray alloc] initWithObjects:@"2393.1", @"3914.8706", @"12007.5426", nil],
                                      [[NSArray alloc] initWithObjects:@"2394.1", @"3914.8704", @"12007.5437", nil],
                                      [[NSArray alloc] initWithObjects:@"2395.2", @"3914.8704", @"12007.5449", nil],
                                      [[NSArray alloc] initWithObjects:@"2396.4", @"3914.8704", @"12007.5463", nil],
                                      [[NSArray alloc] initWithObjects:@"2397.4", @"3914.8706", @"12007.548", nil],
                                      [[NSArray alloc] initWithObjects:@"2398.3", @"3914.8705", @"12007.55", nil],
                                      [[NSArray alloc] initWithObjects:@"2399.3", @"3914.8703", @"12007.5521", nil],
                                      [[NSArray alloc] initWithObjects:@"2400.2", @"3914.8705", @"12007.5543", nil],
                                      [[NSArray alloc] initWithObjects:@"2401.2", @"3914.8712", @"12007.5566", nil],
                                      [[NSArray alloc] initWithObjects:@"2402.1", @"3914.8711", @"12007.5586", nil],
                                      [[NSArray alloc] initWithObjects:@"2402.9", @"3914.8709", @"12007.5603", nil],
                                      [[NSArray alloc] initWithObjects:@"2403.7", @"3914.871", @"12007.562", nil],
                                      [[NSArray alloc] initWithObjects:@"2404.3", @"3914.8715", @"12007.5638", nil],
                                      [[NSArray alloc] initWithObjects:@"2405", @"3914.8719", @"12007.5657", nil],
                                      [[NSArray alloc] initWithObjects:@"2405.7", @"3914.872", @"12007.5675", nil],
                                      [[NSArray alloc] initWithObjects:@"2406.2", @"3914.8724", @"12007.5696", nil],
                                      [[NSArray alloc] initWithObjects:@"2406.7", @"3914.8728", @"12007.5714", nil],
                                      [[NSArray alloc] initWithObjects:@"2407.2", @"3914.8732", @"12007.5734", nil],
                                      [[NSArray alloc] initWithObjects:@"2407.8", @"3914.8738", @"12007.5756", nil],
                                      [[NSArray alloc] initWithObjects:@"2408.3", @"3914.8747", @"12007.5774", nil],
                                      [[NSArray alloc] initWithObjects:@"2409.1", @"3914.8758", @"12007.579", nil],
                                      [[NSArray alloc] initWithObjects:@"2409.7", @"3914.8778", @"12007.5809", nil],
                                      [[NSArray alloc] initWithObjects:@"2410.4", @"3914.8794", @"12007.5828", nil],
                                      [[NSArray alloc] initWithObjects:@"2411", @"3914.8807", @"12007.5847", nil],
                                      [[NSArray alloc] initWithObjects:@"2411.5", @"3914.8814", @"12007.5867", nil],
                                      [[NSArray alloc] initWithObjects:@"2412", @"3914.882", @"12007.5884", nil],
                                      [[NSArray alloc] initWithObjects:@"2412.7", @"3914.8826", @"12007.5906", nil],
                                      [[NSArray alloc] initWithObjects:@"2413.4", @"3914.8841", @"12007.5935", nil],
                                      [[NSArray alloc] initWithObjects:@"2414.1", @"3914.8848", @"12007.5964", nil],
                                      [[NSArray alloc] initWithObjects:@"2414.8", @"3914.8856", @"12007.5987", nil],
                                      [[NSArray alloc] initWithObjects:@"2415.5", @"3914.8863", @"12007.601", nil],
                                      [[NSArray alloc] initWithObjects:@"2416.4", @"3914.8866", @"12007.603", nil],
                                      [[NSArray alloc] initWithObjects:@"2417.4", @"3914.8864", @"12007.6045", nil],
                                      [[NSArray alloc] initWithObjects:@"2418.3", @"3914.8868", @"12007.606", nil],
                                      [[NSArray alloc] initWithObjects:@"2419.2", @"3914.8874", @"12007.6077", nil],
                                      [[NSArray alloc] initWithObjects:@"2419.8", @"3914.8879", @"12007.6092", nil],
                                      [[NSArray alloc] initWithObjects:@"2420.6", @"3914.8889", @"12007.6107", nil],
                                      [[NSArray alloc] initWithObjects:@"2421.4", @"3914.89", @"12007.612", nil],
                                      [[NSArray alloc] initWithObjects:@"2422.2", @"3914.8908", @"12007.6135", nil],
                                      [[NSArray alloc] initWithObjects:@"2422.7", @"3914.8912", @"12007.6149", nil],
                                      [[NSArray alloc] initWithObjects:@"2423.1", @"3914.892", @"12007.6164", nil],
                                      [[NSArray alloc] initWithObjects:@"2423.7", @"3914.8936", @"12007.6174", nil],
                                      [[NSArray alloc] initWithObjects:@"2424.2", @"3914.8948", @"12007.6186", nil],
                                      [[NSArray alloc] initWithObjects:@"2424.8", @"3914.8957", @"12007.6204", nil],
                                      [[NSArray alloc] initWithObjects:@"2425.6", @"3914.8972", @"12007.6227", nil],
                                      [[NSArray alloc] initWithObjects:@"2426.2", @"3914.8981", @"12007.625", nil],
                                      [[NSArray alloc] initWithObjects:@"2426.6", @"3914.9001", @"12007.627", nil],
                                      [[NSArray alloc] initWithObjects:@"2427.1", @"3914.9006", @"12007.6289", nil],
                                      [[NSArray alloc] initWithObjects:@"2427.6", @"3914.9004", @"12007.6303", nil],
                                      [[NSArray alloc] initWithObjects:@"2428.1", @"3914.9003", @"12007.6313", nil],
                                      [[NSArray alloc] initWithObjects:@"2428.5", @"3914.9003", @"12007.6323", nil],
                                      [[NSArray alloc] initWithObjects:@"2428.8", @"3914.9008", @"12007.6338", nil],
                                      [[NSArray alloc] initWithObjects:@"2429", @"3914.9011", @"12007.6355", nil],
                                      [[NSArray alloc] initWithObjects:@"2429.6", @"3914.9024", @"12007.6376", nil],
                                      [[NSArray alloc] initWithObjects:@"2430", @"3914.9038", @"12007.6402", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.5", @"3914.9047", @"12007.6429", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.7", @"3914.9047", @"12007.6458", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.8", @"3914.9053", @"12007.6488", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.2", @"3914.9075", @"12007.6516", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.5", @"3914.9085", @"12007.6547", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.7", @"3914.9092", @"12007.6577", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.9", @"3914.9095", @"12007.6607", nil],
                                      [[NSArray alloc] initWithObjects:@"2432.1", @"3914.9105", @"12007.6635", nil],
                                      [[NSArray alloc] initWithObjects:@"2432.1", @"3914.9114", @"12007.6662", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.7", @"3914.9121", @"12007.6691", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.8", @"3914.9117", @"12007.6726", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.4", @"3914.9112", @"12007.6757", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.2", @"3914.9123", @"12007.6793", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.4", @"3914.9137", @"12007.6824", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.3", @"3914.9141", @"12007.6856", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.5", @"3914.9142", @"12007.6884", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.6", @"3914.9146", @"12007.6912", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.7", @"3914.9145", @"12007.6937", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.7", @"3914.915", @"12007.6962", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.6", @"3914.9158", @"12007.6988", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.5", @"3914.9161", @"12007.7012", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.2", @"3914.9162", @"12007.7037", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.9", @"3914.9166", @"12007.7058", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.9", @"3914.9172", @"12007.708", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.9", @"3914.9182", @"12007.7101", nil],
                                      [[NSArray alloc] initWithObjects:@"2431", @"3914.9191", @"12007.7122", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.1", @"3914.9199", @"12007.7141", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.1", @"3914.9208", @"12007.7161", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.2", @"3914.9217", @"12007.7181", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.3", @"3914.9231", @"12007.7203", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.4", @"3914.9242", @"12007.7227", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.5", @"3914.9253", @"12007.7251", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.3", @"3914.9261", @"12007.7274", nil],
                                      [[NSArray alloc] initWithObjects:@"2431.3", @"3914.9271", @"12007.7299", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.8", @"3914.9286", @"12007.7319", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.7", @"3914.9309", @"12007.7337", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.9", @"3914.9327", @"12007.7353", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.9", @"3914.9342", @"12007.7371", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.9", @"3914.9355", @"12007.7393", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.8", @"3914.9374", @"12007.7413", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.7", @"3914.9392", @"12007.7431", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.4", @"3914.9398", @"12007.7455", nil],
                                      [[NSArray alloc] initWithObjects:@"2430.1", @"3914.9415", @"12007.7484", nil],
                                      [[NSArray alloc] initWithObjects:@"2430", @"3914.9429", @"12007.7514", nil],
                                      [[NSArray alloc] initWithObjects:@"2429.9", @"3914.9455", @"12007.7534", nil],
                                      [[NSArray alloc] initWithObjects:@"2429.6", @"3914.9472", @"12007.7559", nil],
                                      [[NSArray alloc] initWithObjects:@"2429.4", @"3914.9481", @"12007.7591", nil],
                                      [[NSArray alloc] initWithObjects:@"2429.2", @"3914.9494", @"12007.762", nil],
                                      [[NSArray alloc] initWithObjects:@"2429", @"3914.9502", @"12007.765", nil],
                                      [[NSArray alloc] initWithObjects:@"2428.8", @"3914.9516", @"12007.767", nil],
                                      [[NSArray alloc] initWithObjects:@"2428.6", @"3914.9534", @"12007.7691", nil],
                                      [[NSArray alloc] initWithObjects:@"2428.3", @"3914.955", @"12007.7718", nil],
                                      [[NSArray alloc] initWithObjects:@"2427.9", @"3914.9573", @"12007.7742", nil],
                                      [[NSArray alloc] initWithObjects:@"2427.5", @"3914.959", @"12007.7768", nil],
                                      [[NSArray alloc] initWithObjects:@"2427.1", @"3914.9607", @"12007.7795", nil],
                                      [[NSArray alloc] initWithObjects:@"2426.8", @"3914.9622", @"12007.7823", nil],
                                      [[NSArray alloc] initWithObjects:@"2426.4", @"3914.9642", @"12007.7842", nil],
                                      [[NSArray alloc] initWithObjects:@"2426", @"3914.9664", @"12007.7859", nil],
                                      [[NSArray alloc] initWithObjects:@"2425.8", @"3914.9689", @"12007.7874", nil],
                                      [[NSArray alloc] initWithObjects:@"2425.5", @"3914.9712", @"12007.7894", nil],
                                      [[NSArray alloc] initWithObjects:@"2425.2", @"3914.9726", @"12007.7915", nil],
                                      [[NSArray alloc] initWithObjects:@"2425", @"3914.9734", @"12007.794", nil],
                                      [[NSArray alloc] initWithObjects:@"2424.3", @"3914.9744", @"12007.7965", nil],
                                      [[NSArray alloc] initWithObjects:@"2424", @"3914.9768", @"12007.7988", nil],
                                      [[NSArray alloc] initWithObjects:@"2423.5", @"3914.9791", @"12007.8009", nil],
                                      [[NSArray alloc] initWithObjects:@"2423.1", @"3914.9803", @"12007.8036", nil],
                                      [[NSArray alloc] initWithObjects:@"2422.7", @"3914.981", @"12007.8076", nil],
                                      [[NSArray alloc] initWithObjects:@"2422.1", @"3914.9817", @"12007.8115", nil],
                                      [[NSArray alloc] initWithObjects:@"2421.6", @"3914.9836", @"12007.8141", nil],
                                      [[NSArray alloc] initWithObjects:@"2421.3", @"3914.9867", @"12007.8165", nil],
                                      [[NSArray alloc] initWithObjects:@"2420.6", @"3914.9894", @"12007.819", nil],
                                      [[NSArray alloc] initWithObjects:@"2419.9", @"3914.9903", @"12007.822", nil],
                                      [[NSArray alloc] initWithObjects:@"2419.2", @"3914.9912", @"12007.8254", nil],
                                      [[NSArray alloc] initWithObjects:@"2418.4", @"3914.9929", @"12007.8281", nil],
                                      [[NSArray alloc] initWithObjects:@"2417.8", @"3914.9946", @"12007.8308", nil],
                                      [[NSArray alloc] initWithObjects:@"2417.2", @"3914.9955", @"12007.8337", nil],
                                      [[NSArray alloc] initWithObjects:@"2416.6", @"3914.9958", @"12007.8366", nil],
                                      [[NSArray alloc] initWithObjects:@"2416", @"3914.9968", @"12007.8389", nil],
                                      [[NSArray alloc] initWithObjects:@"2414.8", @"3914.998", @"12007.8415", nil],
                                      [[NSArray alloc] initWithObjects:@"2413.6", @"3914.9986", @"12007.8443", nil],
                                      [[NSArray alloc] initWithObjects:@"2412.9", @"3914.9997", @"12007.8469", nil],
                                      [[NSArray alloc] initWithObjects:@"2412.4", @"3915.0006", @"12007.8494", nil],
                                      [[NSArray alloc] initWithObjects:@"2411.8", @"3915.0011", @"12007.8518", nil],
                                      [[NSArray alloc] initWithObjects:@"2411.2", @"3915.0007", @"12007.8538", nil],
                                      [[NSArray alloc] initWithObjects:@"2410.6", @"3915.0008", @"12007.856", nil],
                                      [[NSArray alloc] initWithObjects:@"2409.9", @"3915.0012", @"12007.8578", nil],
                                      [[NSArray alloc] initWithObjects:@"2409", @"3915.0029", @"12007.8585", nil],
                                      [[NSArray alloc] initWithObjects:@"2408.4", @"3915.0041", @"12007.8603", nil],
                                      [[NSArray alloc] initWithObjects:@"2407.7", @"3915.0064", @"12007.8625", nil],
                                      [[NSArray alloc] initWithObjects:@"2407", @"3915.0077", @"12007.8651", nil],
                                      [[NSArray alloc] initWithObjects:@"2406", @"3915.0083", @"12007.8676", nil],
                                      [[NSArray alloc] initWithObjects:@"2405.1", @"3915.0074", @"12007.8703", nil],
                                      [[NSArray alloc] initWithObjects:@"2404.5", @"3915.0066", @"12007.8732", nil],
                                      [[NSArray alloc] initWithObjects:@"2403.6", @"3915.0068", @"12007.876", nil],
                                      [[NSArray alloc] initWithObjects:@"2402.8", @"3915.0078", @"12007.8778", nil],
                                      [[NSArray alloc] initWithObjects:@"2401.7", @"3915.0102", @"12007.88", nil],
                                      [[NSArray alloc] initWithObjects:@"2400.5", @"3915.0124", @"12007.8822", nil],
                                      [[NSArray alloc] initWithObjects:@"2399.4", @"3915.0136", @"12007.8851", nil],
                                      [[NSArray alloc] initWithObjects:@"2398.4", @"3915.0145", @"12007.8883", nil],
                                      [[NSArray alloc] initWithObjects:@"2397.6", @"3915.0153", @"12007.8919", nil],
                                      [[NSArray alloc] initWithObjects:@"2396.8", @"3915.016", @"12007.8954", nil],
                                      [[NSArray alloc] initWithObjects:@"2396", @"3915.0166", @"12007.8984", nil],
                                      [[NSArray alloc] initWithObjects:@"2395", @"3915.0191", @"12007.8997", nil],
                                      [[NSArray alloc] initWithObjects:@"2394", @"3915.0217", @"12007.9007", nil],
                                      [[NSArray alloc] initWithObjects:@"2393", @"3915.0245", @"12007.9019", nil],
                                      [[NSArray alloc] initWithObjects:@"2392.2", @"3915.0264", @"12007.9046", nil],
                                      [[NSArray alloc] initWithObjects:@"2391.3", @"3915.0281", @"12007.9077", nil],
                                      [[NSArray alloc] initWithObjects:@"2390.4", @"3915.03", @"12007.91", nil],
                                      [[NSArray alloc] initWithObjects:@"2389.5", @"3915.0314", @"12007.9109", nil],
                                      [[NSArray alloc] initWithObjects:@"2388.3", @"3915.0361", @"12007.9119", nil],
                                      [[NSArray alloc] initWithObjects:@"2387.4", @"3915.0384", @"12007.9141", nil],
                                      [[NSArray alloc] initWithObjects:@"2386", @"3915.0407", @"12007.9165", nil],
                                      [[NSArray alloc] initWithObjects:@"2384.9", @"3915.0437", @"12007.9177", nil],
                                      [[NSArray alloc] initWithObjects:@"2383.9", @"3915.0466", @"12007.918", nil],
                                      [[NSArray alloc] initWithObjects:@"2382.8", @"3915.0493", @"12007.9181", nil],
                                      [[NSArray alloc] initWithObjects:@"2381.7", @"3915.0517", @"12007.917", nil],
                                      [[NSArray alloc] initWithObjects:@"2380.8", @"3915.0537", @"12007.9174", nil],
                                      [[NSArray alloc] initWithObjects:@"2379.7", @"3915.0569", @"12007.9177", nil],
                                      [[NSArray alloc] initWithObjects:@"2378.5", @"3915.0592", @"12007.9178", nil],
                                      [[NSArray alloc] initWithObjects:@"2377.4", @"3915.062", @"12007.9171", nil],
                                      [[NSArray alloc] initWithObjects:@"2376.4", @"3915.0645", @"12007.9164", nil],
                                      [[NSArray alloc] initWithObjects:@"2376.1", @"3915.0677", @"12007.9164", nil],
                                      [[NSArray alloc] initWithObjects:@"2375.1", @"3915.0703", @"12007.9157", nil],
                                      [[NSArray alloc] initWithObjects:@"2374.1", @"3915.0725", @"12007.9146", nil],
                                      [[NSArray alloc] initWithObjects:@"2372.9", @"3915.0752", @"12007.9128", nil],
                                      [[NSArray alloc] initWithObjects:@"2371.9", @"3915.0767", @"12007.9124", nil],
                                      [[NSArray alloc] initWithObjects:@"2371.5", @"3915.0805", @"12007.9125", nil],
                                      [[NSArray alloc] initWithObjects:@"2370.5", @"3915.0833", @"12007.9124", nil],
                                      [[NSArray alloc] initWithObjects:@"2369.7", @"3915.0849", @"12007.9112", nil],
                                      [[NSArray alloc] initWithObjects:@"2367.3", @"3915.087", @"12007.9095", nil],
                                      [[NSArray alloc] initWithObjects:@"2364.1", @"3915.0913", @"12007.9058", nil],
                                      [[NSArray alloc] initWithObjects:@"2362.5", @"3915.0957", @"12007.9031", nil],
                                      [[NSArray alloc] initWithObjects:@"2361.4", @"3915.0983", @"12007.9032", nil],
                                      [[NSArray alloc] initWithObjects:@"2360.3", @"3915.1008", @"12007.9039", nil],
                                      [[NSArray alloc] initWithObjects:@"2358.9", @"3915.103", @"12007.904", nil],
                                      [[NSArray alloc] initWithObjects:@"2357.9", @"3915.1046", @"12007.9032", nil],
                                      [[NSArray alloc] initWithObjects:@"2357", @"3915.1057", @"12007.9021", nil],
                                      [[NSArray alloc] initWithObjects:@"2356.3", @"3915.1069", @"12007.9006", nil],
                                      [[NSArray alloc] initWithObjects:@"2354", @"3915.1088", @"12007.8992", nil],
                                      [[NSArray alloc] initWithObjects:@"2352.2", @"3915.1124", @"12007.8967", nil],
                                      [[NSArray alloc] initWithObjects:@"2350.7", @"3915.1154", @"12007.8959", nil],
                                      [[NSArray alloc] initWithObjects:@"2349.6", @"3915.1162", @"12007.897", nil],
                                      [[NSArray alloc] initWithObjects:@"2348.6", @"3915.118", @"12007.898", nil],
                                      [[NSArray alloc] initWithObjects:@"2347.8", @"3915.1196", @"12007.8985", nil],
                                      [[NSArray alloc] initWithObjects:@"2346.9", @"3915.1218", @"12007.8979", nil],
                                      [[NSArray alloc] initWithObjects:@"2346.7", @"3915.1238", @"12007.897", nil],
                                      [[NSArray alloc] initWithObjects:@"2345.8", @"3915.1255", @"12007.8967", nil],
                                      [[NSArray alloc] initWithObjects:@"2344.9", @"3915.1266", @"12007.8972", nil],
                                      [[NSArray alloc] initWithObjects:@"2343.9", @"3915.13", @"12007.8984", nil],
                                      [[NSArray alloc] initWithObjects:@"2343.1", @"3915.1323", @"12007.8987", nil],
                                      [[NSArray alloc] initWithObjects:@"2342", @"3915.135", @"12007.898", nil],
                                      [[NSArray alloc] initWithObjects:@"2340.9", @"3915.1376", @"12007.897", nil],
                                      [[NSArray alloc] initWithObjects:@"2339.8", @"3915.1405", @"12007.896", nil],
                                      [[NSArray alloc] initWithObjects:@"2335.7", @"3915.1431", @"12007.8949", nil],
                                      [[NSArray alloc] initWithObjects:@"2333.5", @"3915.1476", @"12007.8917", nil],
                                      [[NSArray alloc] initWithObjects:@"2332.1", @"3915.1507", @"12007.8911", nil],
                                      [[NSArray alloc] initWithObjects:@"2330.8", @"3915.1527", @"12007.8921", nil],
                                      [[NSArray alloc] initWithObjects:@"2329.8", @"3915.1559", @"12007.8922", nil],
                                      [[NSArray alloc] initWithObjects:@"2328.7", @"3915.1588", @"12007.8914", nil],
                                      [[NSArray alloc] initWithObjects:@"2327.5", @"3915.1619", @"12007.8898", nil],
                                      [[NSArray alloc] initWithObjects:@"2326.5", @"3915.1646", @"12007.8879", nil],
                                      [[NSArray alloc] initWithObjects:@"2325.4", @"3915.1672", @"12007.8862", nil],
                                      [[NSArray alloc] initWithObjects:@"2324.4", @"3915.1696", @"12007.8845", nil],
                                      [[NSArray alloc] initWithObjects:@"2323.4", @"3915.1717", @"12007.8831", nil],
                                      [[NSArray alloc] initWithObjects:@"2322.4", @"3915.1732", @"12007.8822", nil],
                                      [[NSArray alloc] initWithObjects:@"2321.3", @"3915.1744", @"12007.8815", nil],
                                      [[NSArray alloc] initWithObjects:@"2320.1", @"3915.1759", @"12007.8808", nil],
                                      [[NSArray alloc] initWithObjects:@"2318.9", @"3915.1786", @"12007.8788", nil],
                                      [[NSArray alloc] initWithObjects:@"2317.9", @"3915.1802", @"12007.8789", nil],
                                      [[NSArray alloc] initWithObjects:@"2316.7", @"3915.184", @"12007.8798", nil],
                                      [[NSArray alloc] initWithObjects:@"2315.4", @"3915.1865", @"12007.8798", nil],
                                      [[NSArray alloc] initWithObjects:@"2314", @"3915.1901", @"12007.8791", nil],
                                      [[NSArray alloc] initWithObjects:@"2312.7", @"3915.1931", @"12007.8783", nil],
                                      [[NSArray alloc] initWithObjects:@"2311", @"3915.1965", @"12007.8772", nil],
                                      [[NSArray alloc] initWithObjects:@"2310", @"3915.1998", @"12007.8766", nil],
                                      [[NSArray alloc] initWithObjects:@"2308.9", @"3915.2024", @"12007.8766", nil],
                                      [[NSArray alloc] initWithObjects:@"2307.9", @"3915.2046", @"12007.8761", nil],
                                      [[NSArray alloc] initWithObjects:@"2306.8", @"3915.2065", @"12007.8753", nil],
                                      [[NSArray alloc] initWithObjects:@"2305.8", @"3915.2086", @"12007.8743", nil],
                                      [[NSArray alloc] initWithObjects:@"2304.8", @"3915.211", @"12007.8729", nil],
                                      [[NSArray alloc] initWithObjects:@"2303.8", @"3915.2132", @"12007.8709", nil],
                                      [[NSArray alloc] initWithObjects:@"2302.9", @"3915.2157", @"12007.8684", nil],
                                      [[NSArray alloc] initWithObjects:@"2301.9", @"3915.2182", @"12007.8662", nil],
                                      [[NSArray alloc] initWithObjects:@"2300.9", @"3915.2209", @"12007.865", nil],
                                      [[NSArray alloc] initWithObjects:@"2299.9", @"3915.2236", @"12007.8639", nil],
                                      [[NSArray alloc] initWithObjects:@"2298.9", @"3915.2261", @"12007.8627", nil],
                                      [[NSArray alloc] initWithObjects:@"2297.9", @"3915.2286", @"12007.8612", nil],
                                      [[NSArray alloc] initWithObjects:@"2297.1", @"3915.231", @"12007.8595", nil],
                                      [[NSArray alloc] initWithObjects:@"2296.1", @"3915.2339", @"12007.8574", nil],
                                      [[NSArray alloc] initWithObjects:@"2295.1", @"3915.236", @"12007.8564", nil],
                                      [[NSArray alloc] initWithObjects:@"2294.2", @"3915.2381", @"12007.8562", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.2", @"3915.242", @"12007.8569", nil],
                                      [[NSArray alloc] initWithObjects:@"2292.2", @"3915.2443", @"12007.8568", nil],
                                      [[NSArray alloc] initWithObjects:@"2291.3", @"3915.2465", @"12007.8562", nil],
                                      [[NSArray alloc] initWithObjects:@"2290.4", @"3915.2484", @"12007.855", nil],
                                      [[NSArray alloc] initWithObjects:@"2289.4", @"3915.2507", @"12007.8536", nil],
                                      [[NSArray alloc] initWithObjects:@"2288.4", @"3915.2526", @"12007.8524", nil],
                                      [[NSArray alloc] initWithObjects:@"2287.4", @"3915.2541", @"12007.851", nil],
                                      [[NSArray alloc] initWithObjects:@"2286.4", @"3915.2557", @"12007.8497", nil],
                                      [[NSArray alloc] initWithObjects:@"2285.4", @"3915.2569", @"12007.8488", nil],
                                      [[NSArray alloc] initWithObjects:@"2284.5", @"3915.2585", @"12007.8483", nil],
                                      [[NSArray alloc] initWithObjects:@"2283.6", @"3915.2602", @"12007.8479", nil],
                                      [[NSArray alloc] initWithObjects:@"2282.6", @"3915.2621", @"12007.8469", nil],
                                      [[NSArray alloc] initWithObjects:@"2281.7", @"3915.2642", @"12007.846", nil],
                                      [[NSArray alloc] initWithObjects:@"2280.9", @"3915.2665", @"12007.8451", nil],
                                      [[NSArray alloc] initWithObjects:@"2279.9", @"3915.2702", @"12007.8422", nil],
                                      [[NSArray alloc] initWithObjects:@"2279", @"3915.2727", @"12007.8422", nil],
                                      [[NSArray alloc] initWithObjects:@"2278.2", @"3915.2746", @"12007.843", nil],
                                      [[NSArray alloc] initWithObjects:@"2277.3", @"3915.2783", @"12007.8436", nil],
                                      [[NSArray alloc] initWithObjects:@"2276.7", @"3915.2814", @"12007.8435", nil],
                                      [[NSArray alloc] initWithObjects:@"2275.7", @"3915.2842", @"12007.8419", nil],
                                      [[NSArray alloc] initWithObjects:@"2274.7", @"3915.2876", @"12007.8416", nil],
                                      [[NSArray alloc] initWithObjects:@"2273.8", @"3915.2909", @"12007.8413", nil],
                                      [[NSArray alloc] initWithObjects:@"2273", @"3915.2955", @"12007.8414", nil],
                                      [[NSArray alloc] initWithObjects:@"2272", @"3915.2982", @"12007.8396", nil],
                                      [[NSArray alloc] initWithObjects:@"2271.2", @"3915.3018", @"12007.8375", nil],
                                      [[NSArray alloc] initWithObjects:@"2270.3", @"3915.305", @"12007.8353", nil],
                                      [[NSArray alloc] initWithObjects:@"2269.3", @"3915.3073", @"12007.8331", nil],
                                      [[NSArray alloc] initWithObjects:@"2268.4", @"3915.3095", @"12007.8309", nil],
                                      [[NSArray alloc] initWithObjects:@"2267.5", @"3915.3117", @"12007.8287", nil],
                                      [[NSArray alloc] initWithObjects:@"2266.5", @"3915.3144", @"12007.8273", nil],
                                      [[NSArray alloc] initWithObjects:@"2265.6", @"3915.3161", @"12007.8246", nil],
                                      [[NSArray alloc] initWithObjects:@"2264.6", @"3915.3164", @"12007.8215", nil],
                                      [[NSArray alloc] initWithObjects:@"2263.7", @"3915.3174", @"12007.8184", nil],
                                      [[NSArray alloc] initWithObjects:@"2262.7", @"3915.3189", @"12007.8153", nil],
                                      [[NSArray alloc] initWithObjects:@"2261.8", @"3915.32", @"12007.813", nil],
                                      [[NSArray alloc] initWithObjects:@"2260.9", @"3915.3223", @"12007.8106", nil],
                                      [[NSArray alloc] initWithObjects:@"2259.9", @"3915.3243", @"12007.8086", nil],
                                      [[NSArray alloc] initWithObjects:@"2259", @"3915.326", @"12007.8061", nil],
                                      [[NSArray alloc] initWithObjects:@"2258.1", @"3915.3285", @"12007.8023", nil],
                                      [[NSArray alloc] initWithObjects:@"2257.1", @"3915.3325", @"12007.7985", nil],
                                      [[NSArray alloc] initWithObjects:@"2256.1", @"3915.3355", @"12007.7955", nil],
                                      [[NSArray alloc] initWithObjects:@"2255.2", @"3915.337", @"12007.7936", nil],
                                      [[NSArray alloc] initWithObjects:@"2254.3", @"3915.339", @"12007.7914", nil],
                                      [[NSArray alloc] initWithObjects:@"2253.3", @"3915.3423", @"12007.7894", nil],
                                      [[NSArray alloc] initWithObjects:@"2252.4", @"3915.3448", @"12007.7878", nil],
                                      [[NSArray alloc] initWithObjects:@"2251.4", @"3915.3472", @"12007.7852", nil],
                                      [[NSArray alloc] initWithObjects:@"2250.2", @"3915.3497", @"12007.7826", nil],
                                      [[NSArray alloc] initWithObjects:@"2249", @"3915.3535", @"12007.7784", nil],
                                      [[NSArray alloc] initWithObjects:@"2247.8", @"3915.3579", @"12007.7736", nil],
                                      [[NSArray alloc] initWithObjects:@"2246.9", @"3915.3621", @"12007.7688", nil],
                                      [[NSArray alloc] initWithObjects:@"2245.7", @"3915.3665", @"12007.7636", nil],
                                      [[NSArray alloc] initWithObjects:@"2244.8", @"3915.3709", @"12007.7592", nil],
                                      [[NSArray alloc] initWithObjects:@"2243.8", @"3915.374", @"12007.7575", nil],
                                      [[NSArray alloc] initWithObjects:@"2242.7", @"3915.3775", @"12007.7562", nil],
                                      [[NSArray alloc] initWithObjects:@"2241.5", @"3915.3805", @"12007.7547", nil],
                                      [[NSArray alloc] initWithObjects:@"2240.5", @"3915.3833", @"12007.7529", nil],
                                      [[NSArray alloc] initWithObjects:@"2239.6", @"3915.3842", @"12007.752", nil],
                                      [[NSArray alloc] initWithObjects:@"2238.5", @"3915.3857", @"12007.7507", nil],
                                      [[NSArray alloc] initWithObjects:@"2237.5", @"3915.3877", @"12007.7492", nil],
                                      [[NSArray alloc] initWithObjects:@"2236.8", @"3915.3873", @"12007.7484", nil],
                                      [[NSArray alloc] initWithObjects:@"2236", @"3915.388", @"12007.7475", nil],
                                      [[NSArray alloc] initWithObjects:@"2235.4", @"3915.3884", @"12007.7468", nil],
                                      [[NSArray alloc] initWithObjects:@"2234.7", @"3915.3895", @"12007.7458", nil],
                                      [[NSArray alloc] initWithObjects:@"2233.7", @"3915.391", @"12007.7444", nil],
                                      [[NSArray alloc] initWithObjects:@"2232.9", @"3915.3924", @"12007.743", nil],
                                      [[NSArray alloc] initWithObjects:@"2232", @"3915.394", @"12007.7419", nil],
                                      [[NSArray alloc] initWithObjects:@"2231.3", @"3915.3956", @"12007.7415", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.6", @"3915.3976", @"12007.7414", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3915.4001", @"12007.7416", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.2", @"3915.4021", @"12007.7414", nil],
                                      [[NSArray alloc] initWithObjects:@"2228.5", @"3915.4038", @"12007.7406", nil],
                                      [[NSArray alloc] initWithObjects:@"2227.8", @"3915.4052", @"12007.7393", nil],
                                      [[NSArray alloc] initWithObjects:@"2227.1", @"3915.4065", @"12007.7375", nil],
                                      [[NSArray alloc] initWithObjects:@"2226.3", @"3915.4077", @"12007.7357", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.5", @"3915.4093", @"12007.7341", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.7", @"3915.4105", @"12007.7333", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.3", @"3915.4133", @"12007.7326", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.3", @"3915.4163", @"12007.7317", nil],
                                      [[NSArray alloc] initWithObjects:@"2221.4", @"3915.4189", @"12007.7313", nil],
                                      [[NSArray alloc] initWithObjects:@"2220.4", @"3915.4226", @"12007.7312", nil],
                                      [[NSArray alloc] initWithObjects:@"2218.2", @"3915.4258", @"12007.7301", nil],
                                      [[NSArray alloc] initWithObjects:@"2217.1", @"3915.4305", @"12007.7279", nil],
                                      [[NSArray alloc] initWithObjects:@"2216.1", @"3915.4338", @"12007.7276", nil],
                                      [[NSArray alloc] initWithObjects:@"2215.4", @"3915.4372", @"12007.7281", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.3", @"3915.4416", @"12007.7279", nil],
                                      [[NSArray alloc] initWithObjects:@"2212.8", @"3915.4457", @"12007.727", nil],
                                      [[NSArray alloc] initWithObjects:@"2211.6", @"3915.45", @"12007.7259", nil],
                                      [[NSArray alloc] initWithObjects:@"2210.4", @"3915.4537", @"12007.7253", nil],
                                      [[NSArray alloc] initWithObjects:@"2209.3", @"3915.4562", @"12007.7257", nil],
                                      [[NSArray alloc] initWithObjects:@"2208.2", @"3915.4593", @"12007.7256", nil],
                                      [[NSArray alloc] initWithObjects:@"2206.9", @"3915.4631", @"12007.7254", nil],
                                      [[NSArray alloc] initWithObjects:@"2205.8", @"3915.4675", @"12007.725", nil],
                                      [[NSArray alloc] initWithObjects:@"2204.8", @"3915.4705", @"12007.7251", nil],
                                      [[NSArray alloc] initWithObjects:@"2203.9", @"3915.4738", @"12007.7254", nil],
                                      [[NSArray alloc] initWithObjects:@"2202.8", @"3915.4771", @"12007.7258", nil],
                                      [[NSArray alloc] initWithObjects:@"2202.1", @"3915.4802", @"12007.7257", nil],
                                      [[NSArray alloc] initWithObjects:@"2201.4", @"3915.483", @"12007.7254", nil],
                                      [[NSArray alloc] initWithObjects:@"2200.3", @"3915.4859", @"12007.7252", nil],
                                      [[NSArray alloc] initWithObjects:@"2198.9", @"3915.4887", @"12007.7254", nil],
                                      [[NSArray alloc] initWithObjects:@"2197.8", @"3915.4916", @"12007.725", nil],
                                      [[NSArray alloc] initWithObjects:@"2196.7", @"3915.4943", @"12007.7243", nil],
                                      [[NSArray alloc] initWithObjects:@"2195.5", @"3915.4971", @"12007.7236", nil],
                                      [[NSArray alloc] initWithObjects:@"2194.2", @"3915.5001", @"12007.7231", nil],
                                      [[NSArray alloc] initWithObjects:@"2193.1", @"3915.5043", @"12007.7233", nil],
                                      [[NSArray alloc] initWithObjects:@"2192.2", @"3915.5073", @"12007.7229", nil],
                                      [[NSArray alloc] initWithObjects:@"2191.3", @"3915.5102", @"12007.7223", nil],
                                      [[NSArray alloc] initWithObjects:@"2190.4", @"3915.5127", @"12007.7217", nil],
                                      [[NSArray alloc] initWithObjects:@"2189.7", @"3915.5144", @"12007.721", nil],
                                      [[NSArray alloc] initWithObjects:@"2189.6", @"3915.5158", @"12007.72", nil],
                                      [[NSArray alloc] initWithObjects:@"2189.6", @"3915.5168", @"12007.7186", nil],
                                      [[NSArray alloc] initWithObjects:@"2188.6", @"3915.5179", @"12007.7168", nil],
                                      [[NSArray alloc] initWithObjects:@"2186.6", @"3915.5192", @"12007.7149", nil],
                                      [[NSArray alloc] initWithObjects:@"2184.4", @"3915.5216", @"12007.7129", nil],
                                      [[NSArray alloc] initWithObjects:@"2181.8", @"3915.5244", @"12007.7111", nil],
                                      [[NSArray alloc] initWithObjects:@"2180", @"3915.527", @"12007.709", nil],
                                      [[NSArray alloc] initWithObjects:@"2178.3", @"3915.53", @"12007.7067", nil],
                                      [[NSArray alloc] initWithObjects:@"2177.3", @"3915.5338", @"12007.7043", nil],
                                      [[NSArray alloc] initWithObjects:@"2176", @"3915.5382", @"12007.7026", nil],
                                      [[NSArray alloc] initWithObjects:@"2174.6", @"3915.5422", @"12007.7006", nil],
                                      [[NSArray alloc] initWithObjects:@"2173.5", @"3915.5458", @"12007.6994", nil],
                                      [[NSArray alloc] initWithObjects:@"2172.2", @"3915.55", @"12007.6987", nil],
                                      [[NSArray alloc] initWithObjects:@"2170.6", @"3915.5544", @"12007.6975", nil],
                                      [[NSArray alloc] initWithObjects:@"2169.2", @"3915.559", @"12007.6962", nil],
                                      [[NSArray alloc] initWithObjects:@"2167.7", @"3915.5643", @"12007.6951", nil],
                                      [[NSArray alloc] initWithObjects:@"2165.9", @"3915.569", @"12007.6935", nil],
                                      [[NSArray alloc] initWithObjects:@"2164", @"3915.5737", @"12007.6918", nil],
                                      [[NSArray alloc] initWithObjects:@"2162.3", @"3915.5784", @"12007.6904", nil],
                                      [[NSArray alloc] initWithObjects:@"2160.6", @"3915.5827", @"12007.6885", nil],
                                      [[NSArray alloc] initWithObjects:@"2158.6", @"3915.5868", @"12007.6859", nil],
                                      [[NSArray alloc] initWithObjects:@"2156.9", @"3915.5914", @"12007.6832", nil],
                                      [[NSArray alloc] initWithObjects:@"2155.2", @"3915.596", @"12007.681", nil],
                                      [[NSArray alloc] initWithObjects:@"2153", @"3915.5999", @"12007.6789", nil],
                                      [[NSArray alloc] initWithObjects:@"2151.1", @"3915.6041", @"12007.6768", nil],
                                      [[NSArray alloc] initWithObjects:@"2149.4", @"3915.6079", @"12007.6754", nil],
                                      [[NSArray alloc] initWithObjects:@"2147.9", @"3915.6128", @"12007.6744", nil],
                                      [[NSArray alloc] initWithObjects:@"2146.2", @"3915.6176", @"12007.6732", nil],
                                      [[NSArray alloc] initWithObjects:@"2144.3", @"3915.6219", @"12007.6711", nil],
                                      [[NSArray alloc] initWithObjects:@"2142", @"3915.6256", @"12007.6684", nil],
                                      [[NSArray alloc] initWithObjects:@"2140.2", @"3915.6297", @"12007.6651", nil],
                                      [[NSArray alloc] initWithObjects:@"2138.5", @"3915.6339", @"12007.6616", nil],
                                      [[NSArray alloc] initWithObjects:@"2137.1", @"3915.6388", @"12007.6586", nil],
                                      [[NSArray alloc] initWithObjects:@"2135.7", @"3915.6437", @"12007.6562", nil],
                                      [[NSArray alloc] initWithObjects:@"2134.2", @"3915.6481", @"12007.6534", nil],
                                      [[NSArray alloc] initWithObjects:@"2137.5", @"3915.6535", @"12007.6508", nil],
                                      [[NSArray alloc] initWithObjects:@"2136.1", @"3915.6568", @"12007.649", nil],
                                      [[NSArray alloc] initWithObjects:@"2135", @"3915.6611", @"12007.6461", nil],
                                      [[NSArray alloc] initWithObjects:@"2133.8", @"3915.6654", @"12007.6441", nil],
                                      [[NSArray alloc] initWithObjects:@"2132.6", @"3915.6693", @"12007.6425", nil],
                                      [[NSArray alloc] initWithObjects:@"2131.4", @"3915.6728", @"12007.6405", nil],
                                      [[NSArray alloc] initWithObjects:@"2130.2", @"3915.6761", @"12007.6381", nil],
                                      [[NSArray alloc] initWithObjects:@"2129.1", @"3915.6779", @"12007.6362", nil],
                                      [[NSArray alloc] initWithObjects:@"2127.9", @"3915.6781", @"12007.6347", nil],
                                      [[NSArray alloc] initWithObjects:@"2126.9", @"3915.6787", @"12007.6334", nil],
                                      [[NSArray alloc] initWithObjects:@"2125.9", @"3915.6797", @"12007.6322", nil],
                                      [[NSArray alloc] initWithObjects:@"2124.8", @"3915.6806", @"12007.631", nil],
                                      [[NSArray alloc] initWithObjects:@"2123.9", @"3915.6812", @"12007.6297", nil],
                                      [[NSArray alloc] initWithObjects:@"2122.9", @"3915.6822", @"12007.6283", nil],
                                      [[NSArray alloc] initWithObjects:@"2122.1", @"3915.6831", @"12007.6266", nil],
                                      [[NSArray alloc] initWithObjects:@"2121.4", @"3915.6842", @"12007.625", nil],
                                      [[NSArray alloc] initWithObjects:@"2120.5", @"3915.6855", @"12007.6228", nil],
                                      [[NSArray alloc] initWithObjects:@"2119.6", @"3915.6872", @"12007.6205", nil],
                                      [[NSArray alloc] initWithObjects:@"2119", @"3915.6889", @"12007.6192", nil],
                                      [[NSArray alloc] initWithObjects:@"2118", @"3915.6913", @"12007.6184", nil],
                                      [[NSArray alloc] initWithObjects:@"2117.3", @"3915.6928", @"12007.6173", nil],
                                      [[NSArray alloc] initWithObjects:@"2116.7", @"3915.6951", @"12007.6147", nil],
                                      [[NSArray alloc] initWithObjects:@"2115.9", @"3915.6972", @"12007.6117", nil],
                                      [[NSArray alloc] initWithObjects:@"2115.1", @"3915.6993", @"12007.6089", nil],
                                      [[NSArray alloc] initWithObjects:@"2114.3", @"3915.7025", @"12007.6063", nil],
                                      [[NSArray alloc] initWithObjects:@"2113.3", @"3915.7053", @"12007.6034", nil],
                                      [[NSArray alloc] initWithObjects:@"2112.4", @"3915.7079", @"12007.601", nil],
                                      [[NSArray alloc] initWithObjects:@"2111.4", @"3915.7119", @"12007.5992", nil],
                                      [[NSArray alloc] initWithObjects:@"2110.3", @"3915.7152", @"12007.597", nil],
                                      [[NSArray alloc] initWithObjects:@"2109.2", @"3915.7185", @"12007.5946", nil],
                                      [[NSArray alloc] initWithObjects:@"2108.2", @"3915.7223", @"12007.5927", nil],
                                      [[NSArray alloc] initWithObjects:@"2107.2", @"3915.7262", @"12007.5918", nil],
                                      [[NSArray alloc] initWithObjects:@"2106.1", @"3915.7307", @"12007.5909", nil],
                                      [[NSArray alloc] initWithObjects:@"2105", @"3915.7351", @"12007.5898", nil],
                                      [[NSArray alloc] initWithObjects:@"2104", @"3915.7398", @"12007.5892", nil],
                                      [[NSArray alloc] initWithObjects:@"2102.9", @"3915.7437", @"12007.5881", nil],
                                      [[NSArray alloc] initWithObjects:@"2101.8", @"3915.7481", @"12007.5868", nil],
                                      [[NSArray alloc] initWithObjects:@"2100.7", @"3915.753", @"12007.5852", nil],
                                      [[NSArray alloc] initWithObjects:@"2099.5", @"3915.7568", @"12007.583", nil],
                                      [[NSArray alloc] initWithObjects:@"2098.3", @"3915.7602", @"12007.5801", nil],
                                      [[NSArray alloc] initWithObjects:@"2097", @"3915.7638", @"12007.5778", nil],
                                      [[NSArray alloc] initWithObjects:@"2095.7", @"3915.768", @"12007.576", nil],
                                      [[NSArray alloc] initWithObjects:@"2094.5", @"3915.772", @"12007.5746", nil],
                                      [[NSArray alloc] initWithObjects:@"2093.1", @"3915.7752", @"12007.5726", nil],
                                      [[NSArray alloc] initWithObjects:@"2091.9", @"3915.7786", @"12007.5691", nil],
                                      [[NSArray alloc] initWithObjects:@"2090.6", @"3915.7821", @"12007.5651", nil],
                                      [[NSArray alloc] initWithObjects:@"2089.4", @"3915.7854", @"12007.5608", nil],
                                      [[NSArray alloc] initWithObjects:@"2088.2", @"3915.7884", @"12007.5561", nil],
                                      [[NSArray alloc] initWithObjects:@"2087.1", @"3915.7907", @"12007.5511", nil],
                                      [[NSArray alloc] initWithObjects:@"2085.9", @"3915.792", @"12007.5461", nil],
                                      [[NSArray alloc] initWithObjects:@"2084.6", @"3915.7937", @"12007.5415", nil],
                                      [[NSArray alloc] initWithObjects:@"2083.3", @"3915.796", @"12007.538", nil],
                                      [[NSArray alloc] initWithObjects:@"2082.1", @"3915.798", @"12007.5349", nil],
                                      [[NSArray alloc] initWithObjects:@"2081", @"3915.7997", @"12007.5324", nil],
                                      [[NSArray alloc] initWithObjects:@"2080", @"3915.8011", @"12007.5305", nil],
                                      [[NSArray alloc] initWithObjects:@"2078.9", @"3915.8027", @"12007.5288", nil],
                                      [[NSArray alloc] initWithObjects:@"2077.7", @"3915.8046", @"12007.5272", nil],
                                      [[NSArray alloc] initWithObjects:@"2076.8", @"3915.8058", @"12007.5258", nil],
                                      [[NSArray alloc] initWithObjects:@"2075.8", @"3915.8065", @"12007.5243", nil],
                                      [[NSArray alloc] initWithObjects:@"2074.9", @"3915.8073", @"12007.5236", nil],
                                      [[NSArray alloc] initWithObjects:@"2074", @"3915.8082", @"12007.5225", nil],
                                      [[NSArray alloc] initWithObjects:@"2073.1", @"3915.8088", @"12007.5215", nil],
                                      [[NSArray alloc] initWithObjects:@"2072.1", @"3915.8094", @"12007.521", nil],
                                      [[NSArray alloc] initWithObjects:@"2071.1", @"3915.8102", @"12007.5205", nil],
                                      [[NSArray alloc] initWithObjects:@"2070.2", @"3915.8109", @"12007.5201", nil],
                                      [[NSArray alloc] initWithObjects:@"2069.2", @"3915.8113", @"12007.5193", nil],
                                      [[NSArray alloc] initWithObjects:@"2068.3", @"3915.8121", @"12007.5182", nil],
                                      [[NSArray alloc] initWithObjects:@"2067.4", @"3915.813", @"12007.5177", nil],
                                      [[NSArray alloc] initWithObjects:@"2066.6", @"3915.8137", @"12007.5174", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.8146", @"12007.5172", nil],
                                      [[NSArray alloc] initWithObjects:@"2065", @"3915.8153", @"12007.5165", nil],
                                      [[NSArray alloc] initWithObjects:@"2064.2", @"3915.8163", @"12007.5156", nil],
                                      [[NSArray alloc] initWithObjects:@"2063.5", @"3915.817", @"12007.5149", nil],
                                      [[NSArray alloc] initWithObjects:@"2062.8", @"3915.8174", @"12007.5136", nil],
                                      [[NSArray alloc] initWithObjects:@"2062.2", @"3915.8182", @"12007.5122", nil],
                                      [[NSArray alloc] initWithObjects:@"2061.3", @"3915.8191", @"12007.5107", nil],
                                      [[NSArray alloc] initWithObjects:@"2060.5", @"3915.8201", @"12007.51", nil],
                                      [[NSArray alloc] initWithObjects:@"2059.8", @"3915.8209", @"12007.511", nil],
                                      [[NSArray alloc] initWithObjects:@"2059.2", @"3915.8216", @"12007.5117", nil],
                                      [[NSArray alloc] initWithObjects:@"2058.6", @"3915.8222", @"12007.5114", nil],
                                      [[NSArray alloc] initWithObjects:@"2058.2", @"3915.8229", @"12007.5108", nil],
                                      [[NSArray alloc] initWithObjects:@"2057.8", @"3915.8242", @"12007.5094", nil],
                                      [[NSArray alloc] initWithObjects:@"2057.4", @"3915.8251", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2056.8", @"3915.8254", @"12007.5073", nil],
                                      [[NSArray alloc] initWithObjects:@"2056.4", @"3915.8259", @"12007.5068", nil],
                                      [[NSArray alloc] initWithObjects:@"2056", @"3915.8262", @"12007.5059", nil],
                                      [[NSArray alloc] initWithObjects:@"2055.9", @"3915.827", @"12007.5052", nil],
                                      [[NSArray alloc] initWithObjects:@"2055.8", @"3915.8272", @"12007.5039", nil],
                                      [[NSArray alloc] initWithObjects:@"2055.5", @"3915.8276", @"12007.5029", nil],
                                      [[NSArray alloc] initWithObjects:@"2055.4", @"3915.8283", @"12007.5013", nil],
                                      [[NSArray alloc] initWithObjects:@"2055.2", @"3915.8288", @"12007.5004", nil],
                                      [[NSArray alloc] initWithObjects:@"2055.1", @"3915.8292", @"12007.4996", nil],
                                      [[NSArray alloc] initWithObjects:@"2054.9", @"3915.8294", @"12007.4988", nil],
                                      [[NSArray alloc] initWithObjects:@"2054.7", @"3915.8288", @"12007.4998", nil],
                                      [[NSArray alloc] initWithObjects:@"2054.5", @"3915.8286", @"12007.5007", nil],
                                      [[NSArray alloc] initWithObjects:@"2054.3", @"3915.8282", @"12007.5016", nil],
                                      [[NSArray alloc] initWithObjects:@"2054.1", @"3915.8275", @"12007.5027", nil],
                                      [[NSArray alloc] initWithObjects:@"2053.9", @"3915.8271", @"12007.5034", nil],
                                      [[NSArray alloc] initWithObjects:@"2053.7", @"3915.8261", @"12007.5034", nil],
                                      [[NSArray alloc] initWithObjects:@"2053.4", @"3915.8255", @"12007.5038", nil],
                                      [[NSArray alloc] initWithObjects:@"2053.1", @"3915.8251", @"12007.5047", nil],
                                      [[NSArray alloc] initWithObjects:@"2052.7", @"3915.8244", @"12007.5058", nil],
                                      [[NSArray alloc] initWithObjects:@"2052.5", @"3915.8239", @"12007.5074", nil],
                                      [[NSArray alloc] initWithObjects:@"2052.4", @"3915.8246", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2052.5", @"3915.8252", @"12007.5083", nil],
                                      [[NSArray alloc] initWithObjects:@"2052.7", @"3915.825", @"12007.5097", nil],
                                      [[NSArray alloc] initWithObjects:@"2053", @"3915.8247", @"12007.5104", nil],
                                      [[NSArray alloc] initWithObjects:@"2053.2", @"3915.8245", @"12007.5113", nil],
                                      [[NSArray alloc] initWithObjects:@"2053.5", @"3915.8236", @"12007.5122", nil],
                                      [[NSArray alloc] initWithObjects:@"2054.7", @"3915.8227", @"12007.513", nil],
                                      [[NSArray alloc] initWithObjects:@"2055.7", @"3915.8232", @"12007.5138", nil],
                                      [[NSArray alloc] initWithObjects:@"2056.7", @"3915.8233", @"12007.5145", nil],
                                      [[NSArray alloc] initWithObjects:@"2057.5", @"3915.8236", @"12007.5148", nil],
                                      [[NSArray alloc] initWithObjects:@"2058.3", @"3915.8234", @"12007.5153", nil],
                                      [[NSArray alloc] initWithObjects:@"2059", @"3915.8235", @"12007.5157", nil],
                                      [[NSArray alloc] initWithObjects:@"2059.4", @"3915.824", @"12007.5159", nil],
                                      [[NSArray alloc] initWithObjects:@"2059.8", @"3915.8237", @"12007.5165", nil],
                                      [[NSArray alloc] initWithObjects:@"2060.1", @"3915.8238", @"12007.517", nil],
                                      [[NSArray alloc] initWithObjects:@"2060.5", @"3915.8238", @"12007.5176", nil],
                                      [[NSArray alloc] initWithObjects:@"2060.8", @"3915.8235", @"12007.5181", nil],
                                      [[NSArray alloc] initWithObjects:@"2061.3", @"3915.8226", @"12007.5185", nil],
                                      [[NSArray alloc] initWithObjects:@"2061.9", @"3915.8208", @"12007.5187", nil],
                                      [[NSArray alloc] initWithObjects:@"2062.4", @"3915.8196", @"12007.519", nil],
                                      [[NSArray alloc] initWithObjects:@"2062.8", @"3915.8192", @"12007.5191", nil],
                                      [[NSArray alloc] initWithObjects:@"2063.4", @"3915.8179", @"12007.5191", nil],
                                      [[NSArray alloc] initWithObjects:@"2063.8", @"3915.8171", @"12007.5196", nil],
                                      [[NSArray alloc] initWithObjects:@"2064.3", @"3915.8163", @"12007.5197", nil],
                                      [[NSArray alloc] initWithObjects:@"2064.5", @"3915.8159", @"12007.5192", nil],
                                      [[NSArray alloc] initWithObjects:@"2064.8", @"3915.8158", @"12007.5193", nil],
                                      [[NSArray alloc] initWithObjects:@"2064.9", @"3915.8157", @"12007.5194", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.1", @"3915.8156", @"12007.5195", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.3", @"3915.8154", @"12007.5196", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.3", @"3915.8152", @"12007.5197", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.3", @"3915.8152", @"12007.5197", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.3", @"3915.8152", @"12007.5197", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.3", @"3915.8152", @"12007.5196", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.3", @"3915.8151", @"12007.5195", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.3", @"3915.8147", @"12007.5194", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.4", @"3915.8143", @"12007.5195", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.4", @"3915.8138", @"12007.5196", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.5", @"3915.8134", @"12007.5198", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.5", @"3915.8129", @"12007.52", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.6", @"3915.8124", @"12007.5201", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.6", @"3915.8119", @"12007.5201", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.7", @"3915.8115", @"12007.5203", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.7", @"3915.8112", @"12007.5204", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.8109", @"12007.5205", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.8108", @"12007.5207", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.9", @"3915.8107", @"12007.5211", nil],
                                      [[NSArray alloc] initWithObjects:@"2066", @"3915.8108", @"12007.5217", nil],
                                      [[NSArray alloc] initWithObjects:@"2066", @"3915.8108", @"12007.5222", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.8105", @"12007.5223", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.9", @"3915.8069", @"12007.5201", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.9", @"3915.8063", @"12007.5196", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.7", @"3915.8054", @"12007.5187", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.7996", @"12007.5156", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.7969", @"12007.5147", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.7915", @"12007.515", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.789", @"12007.5148", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.7894", @"12007.5134", nil],
                                      [[NSArray alloc] initWithObjects:@"2065.8", @"3915.7868", @"12007.5134", nil],
                                      [[NSArray alloc] initWithObjects:@"2066", @"3915.7847", @"12007.513", nil],
                                      [[NSArray alloc] initWithObjects:@"2066.2", @"3915.7824", @"12007.5128", nil],
                                      [[NSArray alloc] initWithObjects:@"2066.5", @"3915.7796", @"12007.5124", nil],
                                      [[NSArray alloc] initWithObjects:@"2066.8", @"3915.777", @"12007.5118", nil],
                                      [[NSArray alloc] initWithObjects:@"2067", @"3915.7743", @"12007.5113", nil],
                                      [[NSArray alloc] initWithObjects:@"2067.3", @"3915.7716", @"12007.511", nil],
                                      [[NSArray alloc] initWithObjects:@"2067.6", @"3915.7677", @"12007.511", nil],
                                      [[NSArray alloc] initWithObjects:@"2068.2", @"3915.7636", @"12007.5114", nil],
                                      [[NSArray alloc] initWithObjects:@"2068.8", @"3915.7613", @"12007.5113", nil],
                                      [[NSArray alloc] initWithObjects:@"2069.3", @"3915.7585", @"12007.5112", nil],
                                      [[NSArray alloc] initWithObjects:@"2069.9", @"3915.7564", @"12007.5111", nil],
                                      [[NSArray alloc] initWithObjects:@"2070.5", @"3915.7543", @"12007.5109", nil],
                                      [[NSArray alloc] initWithObjects:@"2070.9", @"3915.7525", @"12007.5106", nil],
                                      [[NSArray alloc] initWithObjects:@"2071.4", @"3915.7496", @"12007.5105", nil],
                                      [[NSArray alloc] initWithObjects:@"2072.1", @"3915.7466", @"12007.5108", nil],
                                      [[NSArray alloc] initWithObjects:@"2072.8", @"3915.7432", @"12007.5108", nil],
                                      [[NSArray alloc] initWithObjects:@"2073.5", @"3915.7402", @"12007.5108", nil],
                                      [[NSArray alloc] initWithObjects:@"2074.1", @"3915.7372", @"12007.5109", nil],
                                      [[NSArray alloc] initWithObjects:@"2074.8", @"3915.7344", @"12007.5109", nil],
                                      [[NSArray alloc] initWithObjects:@"2075.5", @"3915.7322", @"12007.5106", nil],
                                      [[NSArray alloc] initWithObjects:@"2076.2", @"3915.7302", @"12007.5105", nil],
                                      [[NSArray alloc] initWithObjects:@"2076.9", @"3915.7275", @"12007.5107", nil],
                                      [[NSArray alloc] initWithObjects:@"2077.5", @"3915.7255", @"12007.5109", nil],
                                      [[NSArray alloc] initWithObjects:@"2078", @"3915.7236", @"12007.5107", nil],
                                      [[NSArray alloc] initWithObjects:@"2078.6", @"3915.7214", @"12007.5103", nil],
                                      [[NSArray alloc] initWithObjects:@"2079.1", @"3915.7198", @"12007.5101", nil],
                                      [[NSArray alloc] initWithObjects:@"2079.5", @"3915.7171", @"12007.51", nil],
                                      [[NSArray alloc] initWithObjects:@"2080", @"3915.7153", @"12007.5101", nil],
                                      [[NSArray alloc] initWithObjects:@"2080.3", @"3915.7124", @"12007.511", nil],
                                      [[NSArray alloc] initWithObjects:@"2080.6", @"3915.7102", @"12007.5114", nil],
                                      [[NSArray alloc] initWithObjects:@"2081.1", @"3915.7076", @"12007.5115", nil],
                                      [[NSArray alloc] initWithObjects:@"2081.6", @"3915.7044", @"12007.5118", nil],
                                      [[NSArray alloc] initWithObjects:@"2082", @"3915.7012", @"12007.5119", nil],
                                      [[NSArray alloc] initWithObjects:@"2082.6", @"3915.6987", @"12007.5121", nil],
                                      [[NSArray alloc] initWithObjects:@"2083.1", @"3915.6957", @"12007.5122", nil],
                                      [[NSArray alloc] initWithObjects:@"2083.7", @"3915.6933", @"12007.512", nil],
                                      [[NSArray alloc] initWithObjects:@"2084.2", @"3915.6898", @"12007.5121", nil],
                                      [[NSArray alloc] initWithObjects:@"2084.8", @"3915.6868", @"12007.5119", nil],
                                      [[NSArray alloc] initWithObjects:@"2085.2", @"3915.6843", @"12007.5119", nil],
                                      [[NSArray alloc] initWithObjects:@"2085.7", @"3915.682", @"12007.5121", nil],
                                      [[NSArray alloc] initWithObjects:@"2086.2", @"3915.6792", @"12007.512", nil],
                                      [[NSArray alloc] initWithObjects:@"2086.8", @"3915.6768", @"12007.5121", nil],
                                      [[NSArray alloc] initWithObjects:@"2087.4", @"3915.6744", @"12007.5121", nil],
                                      [[NSArray alloc] initWithObjects:@"2088", @"3915.6713", @"12007.5121", nil],
                                      [[NSArray alloc] initWithObjects:@"2088.7", @"3915.6688", @"12007.512", nil],
                                      [[NSArray alloc] initWithObjects:@"2089.3", @"3915.6671", @"12007.5118", nil],
                                      [[NSArray alloc] initWithObjects:@"2090", @"3915.665", @"12007.5115", nil],
                                      [[NSArray alloc] initWithObjects:@"2090.7", @"3915.6632", @"12007.5112", nil],
                                      [[NSArray alloc] initWithObjects:@"2091.4", @"3915.6611", @"12007.5107", nil],
                                      [[NSArray alloc] initWithObjects:@"2092.1", @"3915.6591", @"12007.5103", nil],
                                      [[NSArray alloc] initWithObjects:@"2092.8", @"3915.6567", @"12007.5101", nil],
                                      [[NSArray alloc] initWithObjects:@"2093.5", @"3915.654", @"12007.5098", nil],
                                      [[NSArray alloc] initWithObjects:@"2094.2", @"3915.6519", @"12007.5097", nil],
                                      [[NSArray alloc] initWithObjects:@"2094.9", @"3915.6492", @"12007.5097", nil],
                                      [[NSArray alloc] initWithObjects:@"2095.7", @"3915.646", @"12007.5099", nil],
                                      [[NSArray alloc] initWithObjects:@"2096.4", @"3915.6433", @"12007.51", nil],
                                      [[NSArray alloc] initWithObjects:@"2097.2", @"3915.6409", @"12007.5097", nil],
                                      [[NSArray alloc] initWithObjects:@"2098", @"3915.639", @"12007.5094", nil],
                                      [[NSArray alloc] initWithObjects:@"2098.8", @"3915.6369", @"12007.5093", nil],
                                      [[NSArray alloc] initWithObjects:@"2099.6", @"3915.6344", @"12007.5093", nil],
                                      [[NSArray alloc] initWithObjects:@"2100.3", @"3915.6323", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2101.1", @"3915.6303", @"12007.509", nil],
                                      [[NSArray alloc] initWithObjects:@"2101.8", @"3915.6279", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2102.6", @"3915.6254", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2103.5", @"3915.6231", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2104.4", @"3915.6216", @"12007.509", nil],
                                      [[NSArray alloc] initWithObjects:@"2105.1", @"3915.6218", @"12007.5087", nil],
                                      [[NSArray alloc] initWithObjects:@"2105.7", @"3915.6216", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2106.2", @"3915.6206", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2106.6", @"3915.6194", @"12007.5073", nil],
                                      [[NSArray alloc] initWithObjects:@"2107", @"3915.618", @"12007.5066", nil],
                                      [[NSArray alloc] initWithObjects:@"2107.3", @"3915.616", @"12007.5063", nil],
                                      [[NSArray alloc] initWithObjects:@"2107.6", @"3915.6138", @"12007.5062", nil],
                                      [[NSArray alloc] initWithObjects:@"2107.9", @"3915.6118", @"12007.5063", nil],
                                      [[NSArray alloc] initWithObjects:@"2108.2", @"3915.6094", @"12007.5063", nil],
                                      [[NSArray alloc] initWithObjects:@"2108.5", @"3915.6066", @"12007.506", nil],
                                      [[NSArray alloc] initWithObjects:@"2108.9", @"3915.6044", @"12007.5059", nil],
                                      [[NSArray alloc] initWithObjects:@"2109.4", @"3915.6018", @"12007.5057", nil],
                                      [[NSArray alloc] initWithObjects:@"2109.8", @"3915.5993", @"12007.5055", nil],
                                      [[NSArray alloc] initWithObjects:@"2110.3", @"3915.597", @"12007.5054", nil],
                                      [[NSArray alloc] initWithObjects:@"2110.8", @"3915.5943", @"12007.5052", nil],
                                      [[NSArray alloc] initWithObjects:@"2111.4", @"3915.5911", @"12007.5052", nil],
                                      [[NSArray alloc] initWithObjects:@"2112", @"3915.5873", @"12007.5053", nil],
                                      [[NSArray alloc] initWithObjects:@"2112.6", @"3915.5844", @"12007.5056", nil],
                                      [[NSArray alloc] initWithObjects:@"2113.3", @"3915.582", @"12007.5056", nil],
                                      [[NSArray alloc] initWithObjects:@"2114", @"3915.5793", @"12007.5055", nil],
                                      [[NSArray alloc] initWithObjects:@"2114.8", @"3915.577", @"12007.5053", nil],
                                      [[NSArray alloc] initWithObjects:@"2115.7", @"3915.574", @"12007.5051", nil],
                                      [[NSArray alloc] initWithObjects:@"2116.4", @"3915.5708", @"12007.5046", nil],
                                      [[NSArray alloc] initWithObjects:@"2117.1", @"3915.5684", @"12007.5044", nil],
                                      [[NSArray alloc] initWithObjects:@"2117.7", @"3915.5657", @"12007.5041", nil],
                                      [[NSArray alloc] initWithObjects:@"2118.5", @"3915.563", @"12007.5037", nil],
                                      [[NSArray alloc] initWithObjects:@"2119.2", @"3915.5607", @"12007.5038", nil],
                                      [[NSArray alloc] initWithObjects:@"2119.8", @"3915.5582", @"12007.5039", nil],
                                      [[NSArray alloc] initWithObjects:@"2120.2", @"3915.5552", @"12007.5035", nil],
                                      [[NSArray alloc] initWithObjects:@"2120.6", @"3915.5523", @"12007.5032", nil],
                                      [[NSArray alloc] initWithObjects:@"2121", @"3915.5491", @"12007.5032", nil],
                                      [[NSArray alloc] initWithObjects:@"2121.3", @"3915.5462", @"12007.5033", nil],
                                      [[NSArray alloc] initWithObjects:@"2121.7", @"3915.5433", @"12007.5034", nil],
                                      [[NSArray alloc] initWithObjects:@"2122", @"3915.54", @"12007.5037", nil],
                                      [[NSArray alloc] initWithObjects:@"2122.6", @"3915.5374", @"12007.5041", nil],
                                      [[NSArray alloc] initWithObjects:@"2123", @"3915.5341", @"12007.5045", nil],
                                      [[NSArray alloc] initWithObjects:@"2123.4", @"3915.5311", @"12007.5049", nil],
                                      [[NSArray alloc] initWithObjects:@"2123.8", @"3915.5287", @"12007.5049", nil],
                                      [[NSArray alloc] initWithObjects:@"2124.2", @"3915.5259", @"12007.5049", nil],
                                      [[NSArray alloc] initWithObjects:@"2124.6", @"3915.5235", @"12007.5048", nil],
                                      [[NSArray alloc] initWithObjects:@"2124.9", @"3915.5213", @"12007.5045", nil],
                                      [[NSArray alloc] initWithObjects:@"2125.3", @"3915.5192", @"12007.5046", nil],
                                      [[NSArray alloc] initWithObjects:@"2125.7", @"3915.517", @"12007.5043", nil],
                                      [[NSArray alloc] initWithObjects:@"2126.3", @"3915.5147", @"12007.5041", nil],
                                      [[NSArray alloc] initWithObjects:@"2126.7", @"3915.5119", @"12007.5036", nil],
                                      [[NSArray alloc] initWithObjects:@"2127", @"3915.5109", @"12007.5037", nil],
                                      [[NSArray alloc] initWithObjects:@"2127.3", @"3915.5089", @"12007.5035", nil],
                                      [[NSArray alloc] initWithObjects:@"2127.6", @"3915.5067", @"12007.5034", nil],
                                      [[NSArray alloc] initWithObjects:@"2128", @"3915.5047", @"12007.5035", nil],
                                      [[NSArray alloc] initWithObjects:@"2128.5", @"3915.5024", @"12007.504", nil],
                                      [[NSArray alloc] initWithObjects:@"2128.9", @"3915.4998", @"12007.5041", nil],
                                      [[NSArray alloc] initWithObjects:@"2129.3", @"3915.497", @"12007.5041", nil],
                                      [[NSArray alloc] initWithObjects:@"2129.8", @"3915.494", @"12007.504", nil],
                                      [[NSArray alloc] initWithObjects:@"2130.1", @"3915.4903", @"12007.504", nil],
                                      [[NSArray alloc] initWithObjects:@"2130.3", @"3915.4872", @"12007.504", nil],
                                      [[NSArray alloc] initWithObjects:@"2130.6", @"3915.4844", @"12007.5037", nil],
                                      [[NSArray alloc] initWithObjects:@"2131", @"3915.4823", @"12007.5034", nil],
                                      [[NSArray alloc] initWithObjects:@"2131.5", @"3915.4787", @"12007.5034", nil],
                                      [[NSArray alloc] initWithObjects:@"2132", @"3915.4762", @"12007.5041", nil],
                                      [[NSArray alloc] initWithObjects:@"2132.4", @"3915.474", @"12007.5044", nil],
                                      [[NSArray alloc] initWithObjects:@"2133.2", @"3915.4715", @"12007.5046", nil],
                                      [[NSArray alloc] initWithObjects:@"2133.5", @"3915.4681", @"12007.5049", nil],
                                      [[NSArray alloc] initWithObjects:@"2133.8", @"3915.465", @"12007.5051", nil],
                                      [[NSArray alloc] initWithObjects:@"2134.2", @"3915.4618", @"12007.5051", nil],
                                      [[NSArray alloc] initWithObjects:@"2134.4", @"3915.4586", @"12007.5051", nil],
                                      [[NSArray alloc] initWithObjects:@"2134.7", @"3915.4559", @"12007.5053", nil],
                                      [[NSArray alloc] initWithObjects:@"2134.8", @"3915.4535", @"12007.5053", nil],
                                      [[NSArray alloc] initWithObjects:@"2135", @"3915.4511", @"12007.5055", nil],
                                      [[NSArray alloc] initWithObjects:@"2135.2", @"3915.4487", @"12007.5056", nil],
                                      [[NSArray alloc] initWithObjects:@"2135.4", @"3915.4459", @"12007.5057", nil],
                                      [[NSArray alloc] initWithObjects:@"2135.8", @"3915.4437", @"12007.5061", nil],
                                      [[NSArray alloc] initWithObjects:@"2136", @"3915.4408", @"12007.5068", nil],
                                      [[NSArray alloc] initWithObjects:@"2136.3", @"3915.4381", @"12007.5072", nil],
                                      [[NSArray alloc] initWithObjects:@"2136.7", @"3915.4354", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2137", @"3915.4325", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2137.4", @"3915.4297", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2137.8", @"3915.4277", @"12007.5084", nil],
                                      [[NSArray alloc] initWithObjects:@"2138.2", @"3915.4258", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2138.7", @"3915.4232", @"12007.5085", nil],
                                      [[NSArray alloc] initWithObjects:@"2139.2", @"3915.421", @"12007.5085", nil],
                                      [[NSArray alloc] initWithObjects:@"2139.7", @"3915.4186", @"12007.5085", nil],
                                      [[NSArray alloc] initWithObjects:@"2140.3", @"3915.4162", @"12007.5083", nil],
                                      [[NSArray alloc] initWithObjects:@"2140.8", @"3915.4135", @"12007.5084", nil],
                                      [[NSArray alloc] initWithObjects:@"2141.4", @"3915.4108", @"12007.5084", nil],
                                      [[NSArray alloc] initWithObjects:@"2141.9", @"3915.4084", @"12007.5084", nil],
                                      [[NSArray alloc] initWithObjects:@"2142.6", @"3915.4056", @"12007.5085", nil],
                                      [[NSArray alloc] initWithObjects:@"2143.3", @"3915.4021", @"12007.5087", nil],
                                      [[NSArray alloc] initWithObjects:@"2144", @"3915.3991", @"12007.5088", nil],
                                      [[NSArray alloc] initWithObjects:@"2144.7", @"3915.3961", @"12007.5089", nil],
                                      [[NSArray alloc] initWithObjects:@"2145.4", @"3915.3944", @"12007.5085", nil],
                                      [[NSArray alloc] initWithObjects:@"2146.1", @"3915.3922", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2146.9", @"3915.39", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2147.6", @"3915.3885", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2148.4", @"3915.3859", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2149.2", @"3915.3834", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2149.9", @"3915.3805", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2150.6", @"3915.3776", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2151.4", @"3915.3764", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2152.3", @"3915.3736", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2153.2", @"3915.3707", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2154.1", @"3915.368", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2154.9", @"3915.3651", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2155.4", @"3915.3615", @"12007.5074", nil],
                                      [[NSArray alloc] initWithObjects:@"2155.9", @"3915.3585", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2156.4", @"3915.3553", @"12007.5076", nil],
                                      [[NSArray alloc] initWithObjects:@"2156.9", @"3915.3522", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2157.5", @"3915.3487", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2158", @"3915.3455", @"12007.5083", nil],
                                      [[NSArray alloc] initWithObjects:@"2158.5", @"3915.3419", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2159.1", @"3915.3381", @"12007.5088", nil],
                                      [[NSArray alloc] initWithObjects:@"2159.6", @"3915.335", @"12007.5089", nil],
                                      [[NSArray alloc] initWithObjects:@"2160.1", @"3915.3322", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2160.5", @"3915.3293", @"12007.5092", nil],
                                      [[NSArray alloc] initWithObjects:@"2161.1", @"3915.3263", @"12007.5094", nil],
                                      [[NSArray alloc] initWithObjects:@"2161.6", @"3915.323", @"12007.5096", nil],
                                      [[NSArray alloc] initWithObjects:@"2162.2", @"3915.3203", @"12007.5097", nil],
                                      [[NSArray alloc] initWithObjects:@"2162.9", @"3915.3176", @"12007.5098", nil],
                                      [[NSArray alloc] initWithObjects:@"2163.5", @"3915.3153", @"12007.5097", nil],
                                      [[NSArray alloc] initWithObjects:@"2164.1", @"3915.3133", @"12007.5095", nil],
                                      [[NSArray alloc] initWithObjects:@"2164.7", @"3915.3111", @"12007.5093", nil],
                                      [[NSArray alloc] initWithObjects:@"2165.4", @"3915.3088", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2166", @"3915.3065", @"12007.5089", nil],
                                      [[NSArray alloc] initWithObjects:@"2166.6", @"3915.3046", @"12007.5088", nil],
                                      [[NSArray alloc] initWithObjects:@"2167.1", @"3915.3024", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2167.6", @"3915.2998", @"12007.5083", nil],
                                      [[NSArray alloc] initWithObjects:@"2168.1", @"3915.2976", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2168.6", @"3915.2957", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2169.3", @"3915.2935", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2169.9", @"3915.2913", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2170.6", @"3915.2886", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2171.3", @"3915.2862", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2171.9", @"3915.2838", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2172.7", @"3915.2817", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2173.3", @"3915.2799", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2173.9", @"3915.2783", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2174.7", @"3915.2767", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2175.5", @"3915.2752", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2176.3", @"3915.2738", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2177", @"3915.2724", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2177.6", @"3915.271", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2178.2", @"3915.2694", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2178.8", @"3915.2679", @"12007.5074", nil],
                                      [[NSArray alloc] initWithObjects:@"2179.3", @"3915.2657", @"12007.5071", nil],
                                      [[NSArray alloc] initWithObjects:@"2180", @"3915.2632", @"12007.5072", nil],
                                      [[NSArray alloc] initWithObjects:@"2180.6", @"3915.2608", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2181.3", @"3915.2578", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2182.1", @"3915.2548", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2182.9", @"3915.2521", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2183.6", @"3915.2498", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2184.4", @"3915.2474", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2185", @"3915.2444", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2185.7", @"3915.2415", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2186.5", @"3915.2393", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2187.5", @"3915.2362", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2188.5", @"3915.2334", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2189.4", @"3915.2305", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2190.3", @"3915.2275", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2191.2", @"3915.2256", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2192.1", @"3915.2234", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2192.7", @"3915.2206", @"12007.5074", nil],
                                      [[NSArray alloc] initWithObjects:@"2193.3", @"3915.2187", @"12007.5072", nil],
                                      [[NSArray alloc] initWithObjects:@"2194.1", @"3915.2169", @"12007.507", nil],
                                      [[NSArray alloc] initWithObjects:@"2194.9", @"3915.2156", @"12007.5067", nil],
                                      [[NSArray alloc] initWithObjects:@"2195.5", @"3915.2135", @"12007.5063", nil],
                                      [[NSArray alloc] initWithObjects:@"2195.9", @"3915.2109", @"12007.5063", nil],
                                      [[NSArray alloc] initWithObjects:@"2196.4", @"3915.209", @"12007.5061", nil],
                                      [[NSArray alloc] initWithObjects:@"2196.9", @"3915.2068", @"12007.506", nil],
                                      [[NSArray alloc] initWithObjects:@"2197.3", @"3915.2046", @"12007.5059", nil],
                                      [[NSArray alloc] initWithObjects:@"2197.7", @"3915.2028", @"12007.5059", nil],
                                      [[NSArray alloc] initWithObjects:@"2198.1", @"3915.2008", @"12007.5061", nil],
                                      [[NSArray alloc] initWithObjects:@"2198.5", @"3915.1983", @"12007.5061", nil],
                                      [[NSArray alloc] initWithObjects:@"2198.9", @"3915.1953", @"12007.5063", nil],
                                      [[NSArray alloc] initWithObjects:@"2199.3", @"3915.1926", @"12007.5066", nil],
                                      [[NSArray alloc] initWithObjects:@"2199.7", @"3915.1898", @"12007.507", nil],
                                      [[NSArray alloc] initWithObjects:@"2200.1", @"3915.1877", @"12007.507", nil],
                                      [[NSArray alloc] initWithObjects:@"2200.5", @"3915.1857", @"12007.507", nil],
                                      [[NSArray alloc] initWithObjects:@"2201.1", @"3915.1836", @"12007.5068", nil],
                                      [[NSArray alloc] initWithObjects:@"2201.7", @"3915.1813", @"12007.5068", nil],
                                      [[NSArray alloc] initWithObjects:@"2202.2", @"3915.1787", @"12007.5069", nil],
                                      [[NSArray alloc] initWithObjects:@"2202.9", @"3915.1767", @"12007.5069", nil],
                                      [[NSArray alloc] initWithObjects:@"2203.5", @"3915.1745", @"12007.5069", nil],
                                      [[NSArray alloc] initWithObjects:@"2204", @"3915.1722", @"12007.5069", nil],
                                      [[NSArray alloc] initWithObjects:@"2204.3", @"3915.1712", @"12007.5067", nil],
                                      [[NSArray alloc] initWithObjects:@"2204.6", @"3915.1708", @"12007.5065", nil],
                                      [[NSArray alloc] initWithObjects:@"2205.1", @"3915.1695", @"12007.5064", nil],
                                      [[NSArray alloc] initWithObjects:@"2205.4", @"3915.1681", @"12007.5064", nil],
                                      [[NSArray alloc] initWithObjects:@"2205.6", @"3915.1663", @"12007.5064", nil],
                                      [[NSArray alloc] initWithObjects:@"2205.8", @"3915.164", @"12007.5065", nil],
                                      [[NSArray alloc] initWithObjects:@"2206.2", @"3915.1615", @"12007.5067", nil],
                                      [[NSArray alloc] initWithObjects:@"2206.4", @"3915.1592", @"12007.5068", nil],
                                      [[NSArray alloc] initWithObjects:@"2206.6", @"3915.1568", @"12007.5071", nil],
                                      [[NSArray alloc] initWithObjects:@"2207", @"3915.1539", @"12007.5068", nil],
                                      [[NSArray alloc] initWithObjects:@"2207.4", @"3915.1518", @"12007.5064", nil],
                                      [[NSArray alloc] initWithObjects:@"2207.8", @"3915.1487", @"12007.5062", nil],
                                      [[NSArray alloc] initWithObjects:@"2208.3", @"3915.1457", @"12007.5062", nil],
                                      [[NSArray alloc] initWithObjects:@"2208.8", @"3915.1429", @"12007.5062", nil],
                                      [[NSArray alloc] initWithObjects:@"2209.5", @"3915.1404", @"12007.5063", nil],
                                      [[NSArray alloc] initWithObjects:@"2210", @"3915.1385", @"12007.5064", nil],
                                      [[NSArray alloc] initWithObjects:@"2210.7", @"3915.1364", @"12007.5066", nil],
                                      [[NSArray alloc] initWithObjects:@"2211.2", @"3915.1349", @"12007.5069", nil],
                                      [[NSArray alloc] initWithObjects:@"2211.7", @"3915.1341", @"12007.5072", nil],
                                      [[NSArray alloc] initWithObjects:@"2212.1", @"3915.1328", @"12007.5076", nil],
                                      [[NSArray alloc] initWithObjects:@"2212.5", @"3915.1307", @"12007.5076", nil],
                                      [[NSArray alloc] initWithObjects:@"2212.8", @"3915.1275", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2213.1", @"3915.1262", @"12007.5073", nil],
                                      [[NSArray alloc] initWithObjects:@"2213.4", @"3915.1239", @"12007.5073", nil],
                                      [[NSArray alloc] initWithObjects:@"2213.7", @"3915.1226", @"12007.5073", nil],
                                      [[NSArray alloc] initWithObjects:@"2213.9", @"3915.1201", @"12007.5074", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.2", @"3915.1179", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.3", @"3915.1156", @"12007.5076", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.5", @"3915.1136", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.6", @"3915.1114", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.7", @"3915.1085", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.8", @"3915.1055", @"12007.5072", nil],
                                      [[NSArray alloc] initWithObjects:@"2215.1", @"3915.1018", @"12007.5071", nil],
                                      [[NSArray alloc] initWithObjects:@"2215.4", @"3915.0982", @"12007.5074", nil],
                                      [[NSArray alloc] initWithObjects:@"2215.6", @"3915.0946", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2216.1", @"3915.0909", @"12007.5076", nil],
                                      [[NSArray alloc] initWithObjects:@"2216.4", @"3915.0871", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2217", @"3915.0835", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2217.5", @"3915.08", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2218.1", @"3915.0763", @"12007.5083", nil],
                                      [[NSArray alloc] initWithObjects:@"2218.6", @"3915.0733", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2219.2", @"3915.0704", @"12007.5084", nil],
                                      [[NSArray alloc] initWithObjects:@"2219.6", @"3915.0678", @"12007.5088", nil],
                                      [[NSArray alloc] initWithObjects:@"2220.1", @"3915.0651", @"12007.509", nil],
                                      [[NSArray alloc] initWithObjects:@"2220.4", @"3915.062", @"12007.5092", nil],
                                      [[NSArray alloc] initWithObjects:@"2220.9", @"3915.0584", @"12007.5094", nil],
                                      [[NSArray alloc] initWithObjects:@"2221.4", @"3915.0554", @"12007.5096", nil],
                                      [[NSArray alloc] initWithObjects:@"2221.8", @"3915.0522", @"12007.5096", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.2", @"3915.0496", @"12007.5095", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.6", @"3915.0474", @"12007.5093", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.9", @"3915.0449", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.3", @"3915.0421", @"12007.5089", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.6", @"3915.0396", @"12007.5089", nil],
                                      [[NSArray alloc] initWithObjects:@"2224", @"3915.0369", @"12007.509", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.6", @"3915.0338", @"12007.509", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.7", @"3915.0309", @"12007.509", nil],
                                      [[NSArray alloc] initWithObjects:@"2225", @"3915.0277", @"12007.509", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.1", @"3915.0242", @"12007.5092", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.5", @"3915.0208", @"12007.5093", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.7", @"3915.0177", @"12007.5093", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.9", @"3915.0153", @"12007.5092", nil],
                                      [[NSArray alloc] initWithObjects:@"2226", @"3915.0123", @"12007.5092", nil],
                                      [[NSArray alloc] initWithObjects:@"2226.2", @"3915.0091", @"12007.5092", nil],
                                      [[NSArray alloc] initWithObjects:@"2226.1", @"3915.0065", @"12007.509", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.9", @"3915.0042", @"12007.5088", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.8", @"3915.0022", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.6", @"3915", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.6", @"3914.9966", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.5", @"3914.9935", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.5", @"3914.9912", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.4", @"3914.9888", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.4", @"3914.9868", @"12007.5073", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.4", @"3914.9849", @"12007.5072", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.3", @"3914.9842", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.2", @"3914.9837", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.1", @"3914.9826", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.9", @"3914.9808", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.7", @"3914.9781", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.6", @"3914.9755", @"12007.5081", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.5", @"3914.9724", @"12007.5082", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.3", @"3914.9693", @"12007.5084", nil],
                                      [[NSArray alloc] initWithObjects:@"2224.2", @"3914.9663", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2224", @"3914.9632", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.9", @"3914.9597", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.7", @"3914.9562", @"12007.5088", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.5", @"3914.9525", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.3", @"3914.9493", @"12007.5092", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.1", @"3914.9464", @"12007.5091", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.9", @"3914.9441", @"12007.5089", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.7", @"3914.9423", @"12007.5086", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.5", @"3914.9407", @"12007.5083", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.2", @"3914.9392", @"12007.508", nil],
                                      [[NSArray alloc] initWithObjects:@"2221.9", @"3914.9372", @"12007.5078", nil],
                                      [[NSArray alloc] initWithObjects:@"2221.6", @"3914.9355", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2221.2", @"3914.9338", @"12007.5076", nil],
                                      [[NSArray alloc] initWithObjects:@"2220.8", @"3914.9321", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2220.5", @"3914.9304", @"12007.5074", nil],
                                      [[NSArray alloc] initWithObjects:@"2220.1", @"3914.9286", @"12007.507", nil],
                                      [[NSArray alloc] initWithObjects:@"2219.7", @"3914.926", @"12007.507", nil],
                                      [[NSArray alloc] initWithObjects:@"2219.2", @"3914.9236", @"12007.5069", nil],
                                      [[NSArray alloc] initWithObjects:@"2218.6", @"3914.9215", @"12007.507", nil],
                                      [[NSArray alloc] initWithObjects:@"2218.1", @"3914.9197", @"12007.5074", nil],
                                      [[NSArray alloc] initWithObjects:@"2217.5", @"3914.9177", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2217", @"3914.9158", @"12007.5079", nil],
                                      [[NSArray alloc] initWithObjects:@"2216.5", @"3914.9138", @"12007.5075", nil],
                                      [[NSArray alloc] initWithObjects:@"2215.9", @"3914.9116", @"12007.5077", nil],
                                      [[NSArray alloc] initWithObjects:@"2215.5", @"3914.9085", @"12007.5087", nil],
                                      [[NSArray alloc] initWithObjects:@"2215", @"3914.9067", @"12007.5092", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.6", @"3914.9041", @"12007.5105", nil],
                                      [[NSArray alloc] initWithObjects:@"2215.3", @"3914.8993", @"12007.5134", nil],
                                      [[NSArray alloc] initWithObjects:@"2217.2", @"3914.8962", @"12007.5145", nil],
                                      [[NSArray alloc] initWithObjects:@"2217.8", @"3914.8972", @"12007.5163", nil],
                                      [[NSArray alloc] initWithObjects:@"2217.6", @"3914.8973", @"12007.5183", nil],
                                      [[NSArray alloc] initWithObjects:@"2217.5", @"3914.8964", @"12007.5201", nil],
                                      [[NSArray alloc] initWithObjects:@"2219.1", @"3914.8962", @"12007.5218", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.4", @"3914.8981", @"12007.5232", nil],
                                      [[NSArray alloc] initWithObjects:@"2225", @"3914.901", @"12007.5238", nil],
                                      [[NSArray alloc] initWithObjects:@"2227.1", @"3914.9025", @"12007.5242", nil],
                                      [[NSArray alloc] initWithObjects:@"2228.6", @"3914.9049", @"12007.5242", nil],
                                      [[NSArray alloc] initWithObjects:@"2228.7", @"3914.9042", @"12007.5238", nil],
                                      [[NSArray alloc] initWithObjects:@"2229", @"3914.9039", @"12007.5246", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.7", @"3914.9035", @"12007.5255", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.1", @"3914.904", @"12007.5266", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.5", @"3914.9039", @"12007.5274", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.8", @"3914.9033", @"12007.5281", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.5", @"3914.9027", @"12007.5283", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.1", @"3914.9025", @"12007.5285", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.8", @"3914.9023", @"12007.5287", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.8", @"3914.9022", @"12007.5291", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.8", @"3914.9022", @"12007.5291", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.8", @"3914.9022", @"12007.5291", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.8", @"3914.9022", @"12007.5291", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.8", @"3914.9022", @"12007.5291", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.8", @"3914.9022", @"12007.5291", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9021", @"12007.5292", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9019", @"12007.5293", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9019", @"12007.5293", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9019", @"12007.5293", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9019", @"12007.5293", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9019", @"12007.5293", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.8", @"3914.902", @"12007.5293", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9021", @"12007.5295", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9021", @"12007.5298", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.902", @"12007.5303", nil],
                                      [[NSArray alloc] initWithObjects:@"2229.9", @"3914.9017", @"12007.5308", nil],
                                      [[NSArray alloc] initWithObjects:@"2230", @"3914.9016", @"12007.5313", nil],
                                      [[NSArray alloc] initWithObjects:@"2230", @"3914.9015", @"12007.5317", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.1", @"3914.9015", @"12007.5321", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.2", @"3914.9015", @"12007.5323", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.2", @"3914.9016", @"12007.5326", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.2", @"3914.9019", @"12007.533", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.3", @"3914.9019", @"12007.533", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.4", @"3914.9019", @"12007.5333", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.5", @"3914.9018", @"12007.5337", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.6", @"3914.9017", @"12007.534", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.7", @"3914.9016", @"12007.5342", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.8", @"3914.9016", @"12007.5344", nil],
                                      [[NSArray alloc] initWithObjects:@"2230.9", @"3914.9017", @"12007.5347", nil],
                                      [[NSArray alloc] initWithObjects:@"2231", @"3914.9018", @"12007.5348", nil],
                                      [[NSArray alloc] initWithObjects:@"2231", @"3914.9019", @"12007.5349", nil],
                                      [[NSArray alloc] initWithObjects:@"2231", @"3914.9019", @"12007.5349", nil],
                                      [[NSArray alloc] initWithObjects:@"2231", @"3914.9019", @"12007.5352", nil],
                                      [[NSArray alloc] initWithObjects:@"2231.1", @"3914.9019", @"12007.5352", nil],
                                      [[NSArray alloc] initWithObjects:@"2231.1", @"3914.9018", @"12007.5355", nil],
                                      [[NSArray alloc] initWithObjects:@"2231.1", @"3914.9018", @"12007.5355", nil],
                                      [[NSArray alloc] initWithObjects:@"2231.4", @"3914.9019", @"12007.5362", nil],
                                      [[NSArray alloc] initWithObjects:@"2233.3", @"3914.901", @"12007.5363", nil],
                                      [[NSArray alloc] initWithObjects:@"2235.1", @"3914.8986", @"12007.5348", nil],
                                      [[NSArray alloc] initWithObjects:@"2236.5", @"3914.8974", @"12007.5341", nil],
                                      [[NSArray alloc] initWithObjects:@"2237.8", @"3914.8961", @"12007.5337", nil],
                                      [[NSArray alloc] initWithObjects:@"2239.9", @"3914.8954", @"12007.5337", nil],
                                      [[NSArray alloc] initWithObjects:@"2241.9", @"3914.8948", @"12007.5337", nil],
                                      [[NSArray alloc] initWithObjects:@"2244.2", @"3914.8942", @"12007.5341", nil],
                                      [[NSArray alloc] initWithObjects:@"2246.2", @"3914.8936", @"12007.5349", nil],
                                      [[NSArray alloc] initWithObjects:@"2248.3", @"3914.893", @"12007.5356", nil],
                                      [[NSArray alloc] initWithObjects:@"2250.3", @"3914.8928", @"12007.5367", nil],
                                      [[NSArray alloc] initWithObjects:@"2252.6", @"3914.8926", @"12007.5378", nil],
                                      [[NSArray alloc] initWithObjects:@"2254.5", @"3914.892", @"12007.539", nil],
                                      [[NSArray alloc] initWithObjects:@"2256.2", @"3914.8917", @"12007.5404", nil],
                                      [[NSArray alloc] initWithObjects:@"2257.9", @"3914.8912", @"12007.5418", nil],
                                      [[NSArray alloc] initWithObjects:@"2259.3", @"3914.8911", @"12007.5427", nil],
                                      [[NSArray alloc] initWithObjects:@"2260.5", @"3914.8909", @"12007.5437", nil],
                                      [[NSArray alloc] initWithObjects:@"2261.7", @"3914.8907", @"12007.5446", nil],
                                      [[NSArray alloc] initWithObjects:@"2263.4", @"3914.8905", @"12007.5455", nil],
                                      [[NSArray alloc] initWithObjects:@"2264.8", @"3914.8901", @"12007.5474", nil],
                                      [[NSArray alloc] initWithObjects:@"2266.2", @"3914.8899", @"12007.5489", nil],
                                      [[NSArray alloc] initWithObjects:@"2268.1", @"3914.8897", @"12007.5502", nil],
                                      [[NSArray alloc] initWithObjects:@"2269.7", @"3914.8899", @"12007.5524", nil],
                                      [[NSArray alloc] initWithObjects:@"2270.7", @"3914.8899", @"12007.5546", nil],
                                      [[NSArray alloc] initWithObjects:@"2271.4", @"3914.8901", @"12007.5568", nil],
                                      [[NSArray alloc] initWithObjects:@"2271.9", @"3914.8906", @"12007.5586", nil],
                                      [[NSArray alloc] initWithObjects:@"2272.5", @"3914.8912", @"12007.5611", nil],
                                      [[NSArray alloc] initWithObjects:@"2274", @"3914.8917", @"12007.5637", nil],
                                      [[NSArray alloc] initWithObjects:@"2275.8", @"3914.8923", @"12007.5664", nil],
                                      [[NSArray alloc] initWithObjects:@"2276.9", @"3914.8933", @"12007.5697", nil],
                                      [[NSArray alloc] initWithObjects:@"2277.7", @"3914.8943", @"12007.5726", nil],
                                      [[NSArray alloc] initWithObjects:@"2278.1", @"3914.8951", @"12007.5752", nil],
                                      [[NSArray alloc] initWithObjects:@"2280.3", @"3914.8961", @"12007.578", nil],
                                      [[NSArray alloc] initWithObjects:@"2286.1", @"3914.8959", @"12007.5802", nil],
                                      [[NSArray alloc] initWithObjects:@"2289.9", @"3914.8936", @"12007.5832", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.4", @"3914.8935", @"12007.5853", nil],
                                      [[NSArray alloc] initWithObjects:@"2295.4", @"3914.8932", @"12007.5884", nil],
                                      [[NSArray alloc] initWithObjects:@"2298.7", @"3914.8928", @"12007.5925", nil],
                                      [[NSArray alloc] initWithObjects:@"2301.3", @"3914.8919", @"12007.5977", nil],
                                      [[NSArray alloc] initWithObjects:@"2303.5", @"3914.8918", @"12007.6002", nil],
                                      [[NSArray alloc] initWithObjects:@"2305.3", @"3914.8928", @"12007.6027", nil],
                                      [[NSArray alloc] initWithObjects:@"2307", @"3914.8939", @"12007.6059", nil],
                                      [[NSArray alloc] initWithObjects:@"2308.2", @"3914.8953", @"12007.6098", nil],
                                      [[NSArray alloc] initWithObjects:@"2309.2", @"3914.8967", @"12007.6134", nil],
                                      [[NSArray alloc] initWithObjects:@"2309.6", @"3914.8982", @"12007.6166", nil],
                                      [[NSArray alloc] initWithObjects:@"2309.7", @"3914.8993", @"12007.6204", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.3", @"3914.8999", @"12007.6249", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.7", @"3914.9002", @"12007.631", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.8", @"3914.9012", @"12007.6368", nil],
                                      [[NSArray alloc] initWithObjects:@"2311.2", @"3914.902", @"12007.6431", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.9", @"3914.9027", @"12007.6503", nil],
                                      [[NSArray alloc] initWithObjects:@"2311.1", @"3914.9026", @"12007.6575", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.9", @"3914.9037", @"12007.6641", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.3", @"3914.9052", @"12007.6701", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.7", @"3914.9065", @"12007.6756", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.6", @"3914.9081", @"12007.6815", nil],
                                      [[NSArray alloc] initWithObjects:@"2311.1", @"3914.91", @"12007.6865", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.8", @"3914.9109", @"12007.6938", nil],
                                      [[NSArray alloc] initWithObjects:@"2310.3", @"3914.9124", @"12007.6993", nil],
                                      [[NSArray alloc] initWithObjects:@"2309.6", @"3914.9151", @"12007.704", nil],
                                      [[NSArray alloc] initWithObjects:@"2309", @"3914.9169", @"12007.7091", nil],
                                      [[NSArray alloc] initWithObjects:@"2308.1", @"3914.9185", @"12007.7129", nil],
                                      [[NSArray alloc] initWithObjects:@"2307.4", @"3914.921", @"12007.717", nil],
                                      [[NSArray alloc] initWithObjects:@"2306.5", @"3914.9253", @"12007.7222", nil],
                                      [[NSArray alloc] initWithObjects:@"2305.8", @"3914.928", @"12007.7285", nil],
                                      [[NSArray alloc] initWithObjects:@"2305", @"3914.9339", @"12007.734", nil],
                                      [[NSArray alloc] initWithObjects:@"2304.1", @"3914.9375", @"12007.7402", nil],
                                      [[NSArray alloc] initWithObjects:@"2303.3", @"3914.9407", @"12007.746", nil],
                                      [[NSArray alloc] initWithObjects:@"2302.2", @"3914.947", @"12007.7517", nil],
                                      [[NSArray alloc] initWithObjects:@"2301.1", @"3914.9512", @"12007.7573", nil],
                                      [[NSArray alloc] initWithObjects:@"2299.8", @"3914.9557", @"12007.7629", nil],
                                      [[NSArray alloc] initWithObjects:@"2298.6", @"3914.9602", @"12007.7687", nil],
                                      [[NSArray alloc] initWithObjects:@"2297.5", @"3914.9638", @"12007.775", nil],
                                      [[NSArray alloc] initWithObjects:@"2296.3", @"3914.9679", @"12007.7813", nil],
                                      [[NSArray alloc] initWithObjects:@"2295", @"3914.9717", @"12007.7876", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.8", @"3914.9747", @"12007.7941", nil],
                                      [[NSArray alloc] initWithObjects:@"2292.4", @"3914.9773", @"12007.8006", nil],
                                      [[NSArray alloc] initWithObjects:@"2291.8", @"3914.9788", @"12007.8072", nil],
                                      [[NSArray alloc] initWithObjects:@"2291.2", @"3914.981", @"12007.815", nil],
                                      [[NSArray alloc] initWithObjects:@"2294.1", @"3914.9825", @"12007.8223", nil],
                                      [[NSArray alloc] initWithObjects:@"2294", @"3914.9856", @"12007.8286", nil],
                                      [[NSArray alloc] initWithObjects:@"2293.4", @"3914.9877", @"12007.8359", nil],
                                      [[NSArray alloc] initWithObjects:@"2292.5", @"3914.9901", @"12007.8419", nil],
                                      [[NSArray alloc] initWithObjects:@"2291.4", @"3914.992", @"12007.8465", nil],
                                      [[NSArray alloc] initWithObjects:@"2290.3", @"3914.996", @"12007.8512", nil],
                                      [[NSArray alloc] initWithObjects:@"2289.2", @"3914.9991", @"12007.8559", nil],
                                      [[NSArray alloc] initWithObjects:@"2287.9", @"3915.0018", @"12007.8601", nil],
                                      [[NSArray alloc] initWithObjects:@"2286.4", @"3915.0089", @"12007.8632", nil],
                                      [[NSArray alloc] initWithObjects:@"2284.9", @"3915.0135", @"12007.8664", nil],
                                      [[NSArray alloc] initWithObjects:@"2283.5", @"3915.0173", @"12007.8704", nil],
                                      [[NSArray alloc] initWithObjects:@"2285.3", @"3915.0208", @"12007.8745", nil],
                                      [[NSArray alloc] initWithObjects:@"2284.5", @"3915.0239", @"12007.8774", nil],
                                      [[NSArray alloc] initWithObjects:@"2283.5", @"3915.0248", @"12007.8789", nil],
                                      [[NSArray alloc] initWithObjects:@"2282.7", @"3915.0275", @"12007.8807", nil],
                                      [[NSArray alloc] initWithObjects:@"2283.9", @"3915.0312", @"12007.882", nil],
                                      [[NSArray alloc] initWithObjects:@"2283.2", @"3915.0319", @"12007.8906", nil],
                                      [[NSArray alloc] initWithObjects:@"2282.2", @"3915.0335", @"12007.8892", nil],
                                      [[NSArray alloc] initWithObjects:@"2281.7", @"3915.0369", @"12007.889", nil],
                                      [[NSArray alloc] initWithObjects:@"2281.1", @"3915.0398", @"12007.8908", nil],
                                      [[NSArray alloc] initWithObjects:@"2280", @"3915.0436", @"12007.8913", nil],
                                      [[NSArray alloc] initWithObjects:@"2279", @"3915.0477", @"12007.8896", nil],
                                      [[NSArray alloc] initWithObjects:@"2278", @"3915.0509", @"12007.887", nil],
                                      [[NSArray alloc] initWithObjects:@"2276.9", @"3915.0533", @"12007.8868", nil],
                                      [[NSArray alloc] initWithObjects:@"2275.8", @"3915.0575", @"12007.8864", nil],
                                      [[NSArray alloc] initWithObjects:@"2274.5", @"3915.0603", @"12007.8839", nil],
                                      [[NSArray alloc] initWithObjects:@"2273.1", @"3915.0645", @"12007.8832", nil],
                                      [[NSArray alloc] initWithObjects:@"2271.7", @"3915.0681", @"12007.8829", nil],
                                      [[NSArray alloc] initWithObjects:@"2270.1", @"3915.0719", @"12007.8825", nil],
                                      [[NSArray alloc] initWithObjects:@"2268.7", @"3915.0755", @"12007.8813", nil],
                                      [[NSArray alloc] initWithObjects:@"2267.3", @"3915.0789", @"12007.8803", nil],
                                      [[NSArray alloc] initWithObjects:@"2265.7", @"3915.0841", @"12007.8795", nil],
                                      [[NSArray alloc] initWithObjects:@"2264.1", @"3915.0892", @"12007.8782", nil],
                                      [[NSArray alloc] initWithObjects:@"2262.3", @"3915.0936", @"12007.8767", nil],
                                      [[NSArray alloc] initWithObjects:@"2260.5", @"3915.0982", @"12007.8751", nil],
                                      [[NSArray alloc] initWithObjects:@"2258.8", @"3915.105", @"12007.8734", nil],
                                      [[NSArray alloc] initWithObjects:@"2257.2", @"3915.1105", @"12007.8717", nil],
                                      [[NSArray alloc] initWithObjects:@"2255.2", @"3915.1164", @"12007.8703", nil],
                                      [[NSArray alloc] initWithObjects:@"2253.6", @"3915.123", @"12007.8689", nil],
                                      [[NSArray alloc] initWithObjects:@"2252", @"3915.1284", @"12007.8668", nil],
                                      [[NSArray alloc] initWithObjects:@"2250.3", @"3915.1337", @"12007.8638", nil],
                                      [[NSArray alloc] initWithObjects:@"2248.7", @"3915.1396", @"12007.8599", nil],
                                      [[NSArray alloc] initWithObjects:@"2252.3", @"3915.1453", @"12007.8559", nil],
                                      [[NSArray alloc] initWithObjects:@"2251.3", @"3915.1483", @"12007.8532", nil],
                                      [[NSArray alloc] initWithObjects:@"2250.1", @"3915.153", @"12007.8505", nil],
                                      [[NSArray alloc] initWithObjects:@"2249", @"3915.1585", @"12007.8474", nil],
                                      [[NSArray alloc] initWithObjects:@"2247.9", @"3915.1638", @"12007.8436", nil],
                                      [[NSArray alloc] initWithObjects:@"2246.7", @"3915.1688", @"12007.8403", nil],
                                      [[NSArray alloc] initWithObjects:@"2245.5", @"3915.1742", @"12007.8374", nil],
                                      [[NSArray alloc] initWithObjects:@"2244.2", @"3915.1804", @"12007.8348", nil],
                                      [[NSArray alloc] initWithObjects:@"2243.1", @"3915.1857", @"12007.8332", nil],
                                      [[NSArray alloc] initWithObjects:@"2241.9", @"3915.1925", @"12007.8319", nil],
                                      [[NSArray alloc] initWithObjects:@"2240.6", @"3915.1978", @"12007.8299", nil],
                                      [[NSArray alloc] initWithObjects:@"2239.5", @"3915.2019", @"12007.8286", nil],
                                      [[NSArray alloc] initWithObjects:@"2238.2", @"3915.2083", @"12007.8272", nil],
                                      [[NSArray alloc] initWithObjects:@"2237", @"3915.2148", @"12007.8258", nil],
                                      [[NSArray alloc] initWithObjects:@"2235.8", @"3915.2209", @"12007.8249", nil],
                                      [[NSArray alloc] initWithObjects:@"2234.6", @"3915.2247", @"12007.8229", nil],
                                      [[NSArray alloc] initWithObjects:@"2233.5", @"3915.2303", @"12007.8206", nil],
                                      [[NSArray alloc] initWithObjects:@"2232.3", @"3915.2362", @"12007.8175", nil],
                                      [[NSArray alloc] initWithObjects:@"2231.1", @"3915.2419", @"12007.8136", nil],
                                      [[NSArray alloc] initWithObjects:@"2230", @"3915.2477", @"12007.8091", nil],
                                      [[NSArray alloc] initWithObjects:@"2228.8", @"3915.2531", @"12007.8039", nil],
                                      [[NSArray alloc] initWithObjects:@"2227.7", @"3915.2585", @"12007.7981", nil],
                                      [[NSArray alloc] initWithObjects:@"2226.5", @"3915.2633", @"12007.7913", nil],
                                      [[NSArray alloc] initWithObjects:@"2225.2", @"3915.2686", @"12007.7856", nil],
                                      [[NSArray alloc] initWithObjects:@"2223.9", @"3915.2745", @"12007.7822", nil],
                                      [[NSArray alloc] initWithObjects:@"2222.3", @"3915.2797", @"12007.7787", nil],
                                      [[NSArray alloc] initWithObjects:@"2221.1", @"3915.2817", @"12007.7744", nil],
                                      [[NSArray alloc] initWithObjects:@"2219.9", @"3915.2862", @"12007.7699", nil],
                                      [[NSArray alloc] initWithObjects:@"2218.6", @"3915.2912", @"12007.7658", nil],
                                      [[NSArray alloc] initWithObjects:@"2217.1", @"3915.2962", @"12007.7618", nil],
                                      [[NSArray alloc] initWithObjects:@"2215.6", @"3915.3018", @"12007.7574", nil],
                                      [[NSArray alloc] initWithObjects:@"2214.3", @"3915.3078", @"12007.7534", nil],
                                      [[NSArray alloc] initWithObjects:@"2213", @"3915.3133", @"12007.7499", nil],
                                      [[NSArray alloc] initWithObjects:@"2211.7", @"3915.319", @"12007.7465", nil],
                                      [[NSArray alloc] initWithObjects:@"2210.4", @"3915.3239", @"12007.7433", nil],
                                      [[NSArray alloc] initWithObjects:@"2209.2", @"3915.3286", @"12007.7406", nil],
                                      [[NSArray alloc] initWithObjects:@"2207.9", @"3915.3341", @"12007.7377", nil],
                                      [[NSArray alloc] initWithObjects:@"2206.6", @"3915.3394", @"12007.7336", nil],
                                      [[NSArray alloc] initWithObjects:@"2205.3", @"3915.3446", @"12007.7287", nil],
                                      [[NSArray alloc] initWithObjects:@"2205.5", @"3915.3489", @"12007.7248", nil],
                                      [[NSArray alloc] initWithObjects:@"2204.6", @"3915.3527", @"12007.7212", nil],
                                      [[NSArray alloc] initWithObjects:@"2203.7", @"3915.3576", @"12007.7182", nil],
                                      [[NSArray alloc] initWithObjects:@"2202.8", @"3915.3606", @"12007.7165", nil],
                                      [[NSArray alloc] initWithObjects:@"2201.8", @"3915.3652", @"12007.7148", nil],
                                      [[NSArray alloc] initWithObjects:@"2200.7", @"3915.3702", @"12007.7132", nil],
                                      [[NSArray alloc] initWithObjects:@"2199.7", @"3915.376", @"12007.713", nil],
                                      [[NSArray alloc] initWithObjects:@"2198.7", @"3915.3831", @"12007.7128", nil],
                                      [[NSArray alloc] initWithObjects:@"2197.8", @"3915.3911", @"12007.7122", nil],
                                      [[NSArray alloc] initWithObjects:@"2196.8", @"3915.3985", @"12007.7108", nil],
                                      [[NSArray alloc] initWithObjects:@"2195.8", @"3915.406", @"12007.709", nil],
                                      [[NSArray alloc] initWithObjects:@"2194.8", @"3915.4117", @"12007.7075", nil],
                                      [[NSArray alloc] initWithObjects:@"2193.6", @"3915.4177", @"12007.7062", nil],
                                      [[NSArray alloc] initWithObjects:@"2192.4", @"3915.4238", @"12007.7047", nil],
                                      [[NSArray alloc] initWithObjects:@"2191.2", @"3915.4286", @"12007.7032", nil],
                                      [[NSArray alloc] initWithObjects:@"2189.9", @"3915.4338", @"12007.7014", nil],
                                      [[NSArray alloc] initWithObjects:@"2188.7", @"3915.4391", @"12007.699", nil],
                                      [[NSArray alloc] initWithObjects:@"2187.5", @"3915.4446", @"12007.6962", nil],
                                      [[NSArray alloc] initWithObjects:@"2186.3", @"3915.4497", @"12007.6929", nil],
                                      [[NSArray alloc] initWithObjects:@"2185.1", @"3915.4556", @"12007.6897", nil],
                                      [[NSArray alloc] initWithObjects:@"2183.9", @"3915.4617", @"12007.6868", nil],
                                      [[NSArray alloc] initWithObjects:@"2182.5", @"3915.4674", @"12007.684", nil],
                                      [[NSArray alloc] initWithObjects:@"2181.3", @"3915.474", @"12007.681", nil],
                                      [[NSArray alloc] initWithObjects:@"2180.1", @"3915.4801", @"12007.6775", nil],
                                      [[NSArray alloc] initWithObjects:@"2178.8", @"3915.4856", @"12007.6744", nil],
                                      [[NSArray alloc] initWithObjects:@"2177.6", @"3915.4911", @"12007.6712", nil],
                                      [[NSArray alloc] initWithObjects:@"2176.4", @"3915.4968", @"12007.6678", nil],
                                      [[NSArray alloc] initWithObjects:@"2175.1", @"3915.5025", @"12007.665", nil],
                                      [[NSArray alloc] initWithObjects:@"2173.9", @"3915.5085", @"12007.6623", nil],
                                      [[NSArray alloc] initWithObjects:@"2172.6", @"3915.5142", @"12007.6598", nil],
                                      [[NSArray alloc] initWithObjects:@"2171.3", @"3915.5203", @"12007.6579", nil],
                                      [[NSArray alloc] initWithObjects:@"2169.9", @"3915.5258", @"12007.6551", nil],
                                      [[NSArray alloc] initWithObjects:@"2168.6", @"3915.531", @"12007.6518", nil],
                                      [[NSArray alloc] initWithObjects:@"2167.3", @"3915.5366", @"12007.6487", nil],
                                      [[NSArray alloc] initWithObjects:@"2165.9", @"3915.5422", @"12007.646", nil],
                                      [[NSArray alloc] initWithObjects:@"2164.5", @"3915.5479", @"12007.6448", nil],
                                      [[NSArray alloc] initWithObjects:@"2163.2", @"3915.553", @"12007.6438", nil],
                                      [[NSArray alloc] initWithObjects:@"2161.9", @"3915.5594", @"12007.6429", nil],
                                      [[NSArray alloc] initWithObjects:@"2160.7", @"3915.566", @"12007.6418", nil],
                                      [[NSArray alloc] initWithObjects:@"2159.5", @"3915.5727", @"12007.6409", nil],
                                      [[NSArray alloc] initWithObjects:@"2158.1", @"3915.5788", @"12007.64", nil],
                                      [[NSArray alloc] initWithObjects:@"2156.7", @"3915.5846", @"12007.638", nil],
                                      [[NSArray alloc] initWithObjects:@"2155.4", @"3915.5897", @"12007.6349", nil],
                                      [[NSArray alloc] initWithObjects:@"2154.1", @"3915.5952", @"12007.6318", nil],
                                      [[NSArray alloc] initWithObjects:@"2152.8", @"3915.6011", @"12007.6281", nil],
                                      [[NSArray alloc] initWithObjects:@"2151.6", @"3915.606", @"12007.6241", nil],
                                      [[NSArray alloc] initWithObjects:@"2150.4", @"3915.6097", @"12007.6203", nil],
                                      [[NSArray alloc] initWithObjects:@"2149.1", @"3915.6141", @"12007.6172", nil],
                                      [[NSArray alloc] initWithObjects:@"2149.4", @"3915.6191", @"12007.6142", nil],
                                      [[NSArray alloc] initWithObjects:@"2148.4", @"3915.6236", @"12007.6108", nil],
                                      [[NSArray alloc] initWithObjects:@"2147.4", @"3915.6278", @"12007.6072", nil],
                                      [[NSArray alloc] initWithObjects:@"2146.2", @"3915.6314", @"12007.6039", nil],
                                      [[NSArray alloc] initWithObjects:@"2145", @"3915.6355", @"12007.6017", nil],
                                      [[NSArray alloc] initWithObjects:@"2143.8", @"3915.6393", @"12007.5996", nil],
                                      [[NSArray alloc] initWithObjects:@"2142.4", @"3915.6448", @"12007.5975", nil],
                                      [[NSArray alloc] initWithObjects:@"2141.1", @"3915.6504", @"12007.5951", nil],
                                      [[NSArray alloc] initWithObjects:@"2139.7", @"3915.6551", @"12007.5923", nil],
                                      [[NSArray alloc] initWithObjects:@"2138.3", @"3915.6615", @"12007.5895", nil],
                                      [[NSArray alloc] initWithObjects:@"2137.1", @"3915.6673", @"12007.5867", nil],
                                      [[NSArray alloc] initWithObjects:@"2135.8", @"3915.6724", @"12007.5839", nil],
                                      [[NSArray alloc] initWithObjects:@"2134.3", @"3915.678", @"12007.5809", nil],
                                      [[NSArray alloc] initWithObjects:@"2133", @"3915.6843", @"12007.579", nil],
                                      [[NSArray alloc] initWithObjects:@"2131.8", @"3915.6905", @"12007.5775", nil],
                                      [[NSArray alloc] initWithObjects:@"2130.6", @"3915.6961", @"12007.5763", nil],
                                      [[NSArray alloc] initWithObjects:@"2129.3", @"3915.7009", @"12007.5748", nil],
                                      [[NSArray alloc] initWithObjects:@"2128.2", @"3915.7066", @"12007.5725", nil],
                                      [[NSArray alloc] initWithObjects:@"2127.1", @"3915.7104", @"12007.5702", nil],
                                      [[NSArray alloc] initWithObjects:@"2126.1", @"3915.7142", @"12007.5685", nil],
                                      [[NSArray alloc] initWithObjects:@"2125", @"3915.7184", @"12007.5668", nil],
                                      [[NSArray alloc] initWithObjects:@"2123.9", @"3915.722", @"12007.5647", nil],
                                      [[NSArray alloc] initWithObjects:@"2122.8", @"3915.7259", @"12007.5623", nil],
                                      [[NSArray alloc] initWithObjects:@"2121.8", @"3915.7291", @"12007.5598", nil],
                                      [[NSArray alloc] initWithObjects:@"2120.9", @"3915.7337", @"12007.5577", nil],
                                      [[NSArray alloc] initWithObjects:@"2119.9", @"3915.7378", @"12007.5553", nil],
                                      [[NSArray alloc] initWithObjects:@"2118.8", @"3915.7429", @"12007.5526", nil],
                                      [[NSArray alloc] initWithObjects:@"2117.9", @"3915.7505", @"12007.5507", nil],
                                      [[NSArray alloc] initWithObjects:@"2117.2", @"3915.7562", @"12007.5513", nil],
                                      [[NSArray alloc] initWithObjects:@"2116.7", @"3915.7667", @"12007.5524", nil],
                                      [[NSArray alloc] initWithObjects:@"2116", @"3915.777", @"12007.5543", nil],
                                      [[NSArray alloc] initWithObjects:@"2114.8", @"3915.7851", @"12007.5568", nil],
                                      [[NSArray alloc] initWithObjects:@"2113.8", @"3915.7901", @"12007.5591", nil],
                                      [[NSArray alloc] initWithObjects:@"2113.1", @"3915.795", @"12007.5614", nil],
                                      [[NSArray alloc] initWithObjects:@"2112.2", @"3915.7993", @"12007.5633", nil],
                                      [[NSArray alloc] initWithObjects:@"2112", @"3915.8039", @"12007.565", nil],
                                      [[NSArray alloc] initWithObjects:@"2111.8", @"3915.8083", @"12007.5671", nil],
                                      [[NSArray alloc] initWithObjects:@"2111.3", @"3915.8118", @"12007.569", nil],
                                      [[NSArray alloc] initWithObjects:@"2110.9", @"3915.8144", @"12007.5706", nil],
                                      [[NSArray alloc] initWithObjects:@"2110.5", @"3915.8159", @"12007.5716", nil],
                                      [[NSArray alloc] initWithObjects:@"2110", @"3915.8177", @"12007.5723", nil],
                                      [[NSArray alloc] initWithObjects:@"2109.4", @"3915.8198", @"12007.5729", nil],
                                      [[NSArray alloc] initWithObjects:@"2109.3", @"3915.8215", @"12007.573", nil],
                                      [[NSArray alloc] initWithObjects:@"2109", @"3915.8249", @"12007.5737", nil],
                                      [[NSArray alloc] initWithObjects:@"2108.8", @"3915.8269", @"12007.5742", nil],
                                      [[NSArray alloc] initWithObjects:@"2108.7", @"3915.8289", @"12007.5746", nil],
                                      [[NSArray alloc] initWithObjects:@"2108.7", @"3915.8305", @"12007.5753", nil],
                                      [[NSArray alloc] initWithObjects:@"2109", @"3915.8311", @"12007.5758", nil],
                                      [[NSArray alloc] initWithObjects:@"2109.6", @"3915.8317", @"12007.5766", nil],
                                      [[NSArray alloc] initWithObjects:@"2110.6", @"3915.8313", @"12007.5768", nil],
                                      [[NSArray alloc] initWithObjects:@"2111.8", @"3915.8314", @"12007.5767", nil],
                                      [[NSArray alloc] initWithObjects:@"2112.8", @"3915.8319", @"12007.5765", nil],
                                      [[NSArray alloc] initWithObjects:@"2113.3", @"3915.8317", @"12007.5762", nil],
                                      [[NSArray alloc] initWithObjects:@"2114", @"3915.8326", @"12007.5762", nil],
                                      [[NSArray alloc] initWithObjects:@"2114.7", @"3915.8333", @"12007.5764", nil],
                                      [[NSArray alloc] initWithObjects:@"2115.7", @"3915.8346", @"12007.5768", nil],
                                      [[NSArray alloc] initWithObjects:@"2116.5", @"3915.8336", @"12007.5767", nil],
                                      [[NSArray alloc] initWithObjects:@"2117", @"3915.8335", @"12007.5768", nil],
                                      [[NSArray alloc] initWithObjects:@"2117.7", @"3915.8336", @"12007.577", nil],
                                      [[NSArray alloc] initWithObjects:@"2118.5", @"3915.832", @"12007.5767", nil],
                                      [[NSArray alloc] initWithObjects:@"2118.9", @"3915.8315", @"12007.5766", nil],
                                      [[NSArray alloc] initWithObjects:@"2119.2", @"3915.8309", @"12007.576", nil],
                                      [[NSArray alloc] initWithObjects:@"2119.9", @"3915.83", @"12007.5753", nil],
                                      [[NSArray alloc] initWithObjects:@"2120.6", @"3915.8296", @"12007.5753", nil],
                                      [[NSArray alloc] initWithObjects:@"2121.3", @"3915.8293", @"12007.5754", nil],
                                      [[NSArray alloc] initWithObjects:@"2122", @"3915.8289", @"12007.5756", nil],
                                      [[NSArray alloc] initWithObjects:@"2122.7", @"3915.8285", @"12007.5759", nil],
                                      [[NSArray alloc] initWithObjects:@"2123.5", @"3915.8282", @"12007.5761", nil],
                                      [[NSArray alloc] initWithObjects:@"2124.3", @"3915.8278", @"12007.5763", nil],
                                      [[NSArray alloc] initWithObjects:@"2124.9", @"3915.8274", @"12007.5767", nil],
                                      [[NSArray alloc] initWithObjects:@"2125.6", @"3915.8262", @"12007.5767", nil],
                                      [[NSArray alloc] initWithObjects:@"2126.3", @"3915.8244", @"12007.5766", nil],
                                      [[NSArray alloc] initWithObjects:@"2126.7", @"3915.8229", @"12007.5756", nil],
                                      [[NSArray alloc] initWithObjects:@"2127.5", @"3915.8213", @"12007.5743", nil],
                                      [[NSArray alloc] initWithObjects:@"2128", @"3915.8196", @"12007.5724", nil],
                                      [[NSArray alloc] initWithObjects:@"2128.4", @"3915.8176", @"12007.5705", nil],
                                      [[NSArray alloc] initWithObjects:@"2128.8", @"3915.816", @"12007.5692", nil],
                                      [[NSArray alloc] initWithObjects:@"2129.1", @"3915.8143", @"12007.5678", nil],
                                      [[NSArray alloc] initWithObjects:@"2129.5", @"3915.8128", @"12007.5663", nil],
                                      [[NSArray alloc] initWithObjects:@"2130.6", @"3915.8112", @"12007.5651", nil],
                                      [[NSArray alloc] initWithObjects:@"2131.7", @"3915.8098", @"12007.5636", nil],
                                      [[NSArray alloc] initWithObjects:@"2132.8", @"3915.8087", @"12007.562", nil],
                                      [[NSArray alloc] initWithObjects:@"2133", @"3915.8078", @"12007.5609", nil],
                                      [[NSArray alloc] initWithObjects:@"2133.3", @"3915.8076", @"12007.561", nil],
                                      nil];
  
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
  NSMutableArray  * trail_match_result = [NSMutableArray new];
  /*********************************JERRY TRAIL CALCULATION START ******************************/
  int user_array_last_index = [my_trail_data count]-1 ;
  for (int i = 0; i < user_array_last_index; i++) {
    NSInteger user_elv = [self get_elv:my_trail_data atIndex:i]*3;
    float Lamberjack_elv_diff = 0;
    NSLog(@"user elv is %ld", (long)user_elv);
    NSLog(@"Lamberjack elv is %d - %d", Lamberjack_elv_first, Lamberjack_elv_last);
    if(user_elv >= Lamberjack_elv_first && user_elv <= Lamberjack_elv_last){
      NSLog(@"looking Lamberjack");
      int at_Lamberjack_index = [googleMap_Lamberjack count]-1- (user_elv-Lamberjack_elv_first)/roundStep;
      Lamberjack_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_Lamberjack :at_Lamberjack_index];
      //NSLog(@"Lamberjack diff %d", Lamberjack_elv_diff);
    }else{
      Lamberjack_elv_diff = -1;
    }
    NSLog(@"LowerMainStreet elv is %d - %d", LowerMainStreet_elv_first, LowerMainStreet_elv_last);
    float LowerMainStreet_elv_diff = 0;
    if(user_elv >= LowerMainStreet_elv_first && user_elv <= LowerMainStreet_elv_last){
      NSLog(@"looking LowerMain");
      NSLog(@"LowerMainStreet total count is %d, steps is %d", [googleMap_LowerMainStreet count],(user_elv-LowerMainStreet_elv_first)/roundStep);
      int at_LowerMainStreet_index = [googleMap_LowerMainStreet count]-1- (user_elv-LowerMainStreet_elv_first)/roundStep;
      LowerMainStreet_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_LowerMainStreet :at_LowerMainStreet_index];
    }else{
      LowerMainStreet_elv_diff = -1;
    }
    NSLog(@"MagicMoguls elv is %d - %d", MagicMoguls_elv_first, MagicMoguls_elv_last);
    float MagicMoguls_elv_diff = 0;
    if(user_elv >= MagicMoguls_elv_first && user_elv <= MagicMoguls_elv_last){
      NSLog(@"looking Magic");
      int at_MagicMoguls_index = [googleMap_MagicMoguls count]-1- (user_elv-MagicMoguls_elv_first)/roundStep;
      MagicMoguls_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_MagicMoguls :at_MagicMoguls_index];
    }else{
      MagicMoguls_elv_diff = -1;
    }
    NSLog(@"Siderwinder elv is %d - %d", Siderwinder_elv_first, Siderwinder_elv_last);
    float Siderwinder_elv_diff = 0;
    if(user_elv >= Siderwinder_elv_first && user_elv <= Siderwinder_elv_last){
      NSLog(@"looking Siderwinder");
      int at_Siderwinder_index = [googleMap_Siderwinder count]-1- (user_elv-Siderwinder_elv_first)/roundStep;
      Siderwinder_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_Siderwinder :at_Siderwinder_index];
    }else{
      Siderwinder_elv_diff = -1;
    }
    NSLog(@"SkidTrail elv is %d - %d", SkidTrail_elv_first, SkidTrail_elv_last);
    float SkidTrail_elv_diff = 0;
    if(user_elv >= SkidTrail_elv_first && user_elv <= SkidTrail_elv_last){
      NSLog(@"looking SkidTrail");
      int at_SkidTrail_index = [googleMap_SkidTrail count]-1- (user_elv-SkidTrail_elv_first)/roundStep;
      SkidTrail_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_SkidTrail :at_SkidTrail_index];
    }else{
      SkidTrail_elv_diff = -1;
    }
    NSLog(@"TheGulch elv is %d - %d", TheGulch_elv_first, TheGulch_elv_last);
    float TheGulch_elv_diff = 0;
    if(user_elv >= TheGulch_elv_first && user_elv <= TheGulch_elv_last){
      NSLog(@"looking Gulch");
      int at_TheGulch_index = [googleMap_TheGulch count]-1- (user_elv-TheGulch_elv_first)/roundStep;
      TheGulch_elv_diff = [self get_distance:my_trail_data user_index:i :googleMap_TheGulch :at_TheGulch_index];
    }else{
      TheGulch_elv_diff = -1;
    }
    NSArray  *trail_diff = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:Lamberjack_elv_diff], [NSNumber numberWithInt:LowerMainStreet_elv_diff], [NSNumber numberWithInt:MagicMoguls_elv_diff], [NSNumber numberWithInt:Siderwinder_elv_diff], [NSNumber numberWithInt:SkidTrail_elv_diff], [NSNumber numberWithInt:TheGulch_elv_diff], nil];
    float min = 999999999.0;
    NSInteger match_trail = -1;
    for (int j = 0; j < [trail_diff count]; j++) {
        NSLog(@"diff is %f",[[trail_diff objectAtIndex:j] floatValue] );
      if([[trail_diff objectAtIndex:j] integerValue] != -1 && [[trail_diff objectAtIndex:j] floatValue]<min){
        NSLog(@"==filtering @index %d", j);
        min = [[trail_diff objectAtIndex:j] floatValue];
        NSLog(@"min updated as %f", min);
        match_trail  = j;
      }
    }
    [trail_match_result addObject:[NSNumber numberWithInt:match_trail]];
    
  }
  for (int tom = 0; tom < [trail_match_result count]; tom++){
    NSLog(@"match -->%d %d", tom, [[trail_match_result objectAtIndex:tom] integerValue]);
  }
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

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//  NSLog(@"innitWithNibName");
//  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//  if (self) {
//    // Custom initialization
//    self.zoomed = NO;
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//  }
//  return self;
//}


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

- (float) get_elv: (NSArray *) data atIndex: (int) i
{
  return [[[data objectAtIndex:i] objectAtIndex:0] floatValue    ];
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
  
//  NSLog(@"u_index is %d and trail_index is %d and diff is %f", u_index, trail_index, pow(([self get_n:user atIndex:u_index]*1000-[self get_n:trail atIndex:trail_index]*100000), 2) - pow(([self get_w:user atIndex:u_index]*1000-[self get_w:trail atIndex:trail_index]*100000),2));
//  NSLog(@"(%f-%f)^2 = %f - (%f-%f)^2 = %f", [self get_n:user atIndex:u_index]*1000, [self get_n:trail atIndex:trail_index]*100000,pow(([self get_n:user atIndex:u_index]*1000-[self get_n:trail atIndex:trail_index]*100000), 2), [self get_w:user atIndex:u_index]*1000,  [self get_w:trail atIndex:trail_index]*100000,  pow(([self get_w:user atIndex:u_index]*1000-[self get_w:trail atIndex:trail_index]*100000),2));
  return pow(([self get_n:user atIndex:u_index]*1000-[self get_n:trail atIndex:trail_index]*100000), 2) - pow(([self get_w:user atIndex:u_index]*1000-[self get_w:trail atIndex:trail_index]*100000),2);

}

@end
