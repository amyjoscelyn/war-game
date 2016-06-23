//
//  CardView.swift
//  WarGame
//
//  Created by Amy Joscelyn on 6/23/16.
//  Copyright © 2016 Amy Joscelyn. All rights reserved.
//

import UIKit

class CardView: UIView
{
    var view: UIView!
    @IBOutlet weak var label: UILabel!
    
    var card: Card? {
        didSet {
            if let card = self.card {
                label.text = card.cardLabel }
            else {
                label.text = ""
            }
        }
    }
    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CardView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    func xibSetup()
    {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)! //this is causing an infinite loop
        
        if let v = self.view
        {
            if v.subviews.count == 0
            {
                xibSetup()
            }
        }
        
    }
    
//    -(id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//    if (self.subviews.count == 0) {
//    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
//    UIView *subview = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
//    subview.frame = self.bounds;
//    [self addSubview:subview];
//    }
//    }
//    return self;
//    }
}
