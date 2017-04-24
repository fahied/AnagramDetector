//
//  ViewController.m
//  Anagram
//
//  Created by Fahied on 21/04/2017.
//  Copyright © 2017 OLX PK. All rights reserved.
//

#import "ViewController.h"
#import "AnagramDetector.h"
#import "NSArray+Utilities.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)loadAnagrams:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *text = [[self loadWordsFromFile:@"wordlist"] prettyPrint];
    self.textView.text = text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAnagrams:(id)sender {
    
    NSArray *words = [self loadWordsFromFile:@"wordlist"];
    AnagramDetector *finder = [AnagramDetector new];
    _textView.text = [[finder detectAnagramsFromWords:words] prettyPrint];
}


//helpers
- (NSArray*)loadWordsFromFile:(NSString *)fileName {
    
    NSString *dictionaryPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:dictionaryPath encoding:NSMacOSRomanStringEncoding error:nil];
    NSArray *words = [fileContents componentsSeparatedByString:@"\r\n"];
    return words;
}
@end
