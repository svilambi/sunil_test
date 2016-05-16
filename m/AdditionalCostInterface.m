/* AdditionalCostInterface.h created by xiaoning ding on Fri 06-June-2000 */

#import "AdditionalCostInterface.h"

@implementation AdditionalCostInterface

-(NSString *)commodity
{
    return commodity;
}

-(NSString *)currency
{
    return currency;
}

-(NSString *)uom
{
    return uom;
}
		
-(NSString *)comments
{
    return comments;
}

-(NSString *)counterParty
{
    return counterParty;
}

-(NSString *)drawTo
{
    return drawTo;
}

-(NSDecimalNumber *)costNum
{
    return costNum;
}
	
-(NSString *)editable
{
    return editable;
}

-(NSString *)deletable
{
    return deletable;
}

-(NSDecimalNumber *)price
{
    return price;
}
		
-(NSString *)primarySecondary
{
    return primarySecondary;
}

-(NSString *)payRecv
{
    return payRecv;
}
		
- (NSString *)flatCalc	
{
    return flatCalc;
}

-(Accumulation *)accumuation
{
    return accumuation;
}

-(NSDecimalNumber *)estimateCostNum
{
    return estimateCostNum;
}

-(void)setCommodity:(NSString *)aValue
{
    [commodity autorelease];
    commodity = [aValue retain];
}

-(void)setCurrency:(NSString *)aValue
{
    [currency autorelease];
    currency = [aValue retain];
}
	
-(void)setUom:(NSString *)aValue
{
    [uom autorelease];
    uom = [aValue retain];
}
		
-(void)setComments:(NSString *)aValue
{
    [comments autorelease];
    comments = [aValue retain];
}

-(void)setCounterParty:(NSString *)aValue
{
    [counterParty autorelease];
    counterParty = [aValue retain];
}

-(void)setDrawTo:(NSString *)aValue
{
    [drawTo autorelease];
    drawTo = [aValue retain];
}

-(void)setCostNum:(NSDecimalNumber *)aValue
{
    [costNum autorelease];
    costNum = [aValue retain];
}
	
-(void)setEditable:(NSString *)aValue
{
    [editable autorelease];
    editable = [aValue retain];
}

-(void)setDeletable:(NSString *)aValue
{
    [deletable autorelease];
    deletable = [aValue retain];
}

-(void)setPrice:(NSDecimalNumber *)aValue
{
    [price autorelease];
    price = [aValue retain];
}
		
-(void)setPrimarySecondary:(NSString *)aValue
{
    [primarySecondary autorelease];
    primarySecondary = [aValue retain];
}
	
-(void)setPayRecv:(NSString *)aValue
{
    [payRecv autorelease];
    payRecv = [aValue retain];
}
		
-(void)setFlatCalc:(NSString *)aValue
{
    [flatCalc autorelease];
    flatCalc = [aValue retain];
}
	
-(void)setAccumuation:(Accumulation *)aValue
{
    [accumuation autorelease];
    accumuation = [aValue retain];
}

-(void)setEstimateCostNum:(NSDecimalNumber *)aValue
{
    [estimateCostNum autorelease];
    estimateCostNum = [aValue retain];
}

@end
