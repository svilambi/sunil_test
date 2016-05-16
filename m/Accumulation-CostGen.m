/* Accumulation-CostGen.m created by suzimin on Tue 25-Jan-2000 */

#import "Accumulation-CostGen.h"
#import <JMFoundation/JMFoundation.h>
#import <IctsEOsAdditions/IctsEOsAdditions.h>
#import "PaymentTerm-CostGen.h"
#import <Trade/Trade.h>

#define SECONDS_OF_DAY		86400

@implementation Accumulation (CostGen)

- (NSCalendarDate *) calculatedSettlementDate
{
        TradeItem *aTradeItem = [self tradeItem];
        TradeOrder *aTradeOrder = [aTradeItem tradeOrder];
        NSString *settlementType = [aTradeOrder cashSettleType];
        NSCalendarDate *aDate;
//        Calendar *bookingCompCal = [[[[[self tradeItem] bookingCompany] bookingCompanyInfos] firstObject] calendar];
//        Calendar *priceCurrCal = [[[self priceCurrency] country] calendar];
        BOOL goForward = YES;

        if ([[aTradeOrder cashSettleHolidays] isEqualToString:@"P"])
            goForward = NO;

        if (!settlementType || [settlementType isEqualToString:CASH_END_OF_CONTRACT_FREQ]) {
            Accumulation *lastAccum = [[aTradeItem accumulations] lastObject];
            //aDate = [[[lastAccum quoteEndDate] copy] autorelease];
            //Issue 429 -- SEMPRA wants to use accumEndDate -- and issue 8304
            aDate = [[[lastAccum accumEndDate] copy] autorelease];
            //Issue 6769 -- SEMPRA wants to use nominalEndDate
            //aDate = [[[lastAccum nominalEndDate] copy] autorelease];
        } else if ([settlementType isEqualToString:CASH_PERIODIC_FREQ])
            aDate = [self adjustedPeriodicStartDate];
        else {	// Specific dates
            CashSettleDate *aCs;
                NSEnumerator *e = [[aTradeOrder cashSettleDates] objectEnumerator];
                NSCalendarDate *tmpDate = nil;

                aDate = [[[self quoteEndDate] copy] autorelease];
                while (aCs=[e nextObject]) {

                        if ([aDate compareWith:[aCs cashSettleDate]]>=0 &&
                                        (!tmpDate || [tmpDate compareWith:[aCs cashSettleDate]]<0)) {
                                tmpDate = [aCs cashSettleDate];
                                aDate = [[tmpDate copy] autorelease];
                        }
                }
        }
/** issue 8304 -- need the date to be whatever it comes out to be....
        if ([aDate isWeekend]) {
            int day=[aDate dayOfWeek];

            if (day==0) {   // sunday
                if ([[aTradeOrder cashSettleSundays] isEqualToString:@"N"])
                    aDate = [aDate dateByAddingDays:1];
                else
                    aDate = [aDate dateByAddingDays:-2];
            } else {  // saturday
                if ([[aTradeOrder cashSettleSaturdays] isEqualToString:@"N"]) //N is next business day, P is previous
                    aDate = [aDate dateByAddingDays:2];
                else
                    aDate = [aDate dateByAddingDays:-1];
            }
        }

        if ( [bookingCompCal isHoliday:aDate] || [priceCurrCal isHoliday:aDate] ) {
            while( [bookingCompCal isHoliday:aDate] || [priceCurrCal isHoliday:aDate] ){
                if (goForward)
                    aDate = [aDate dateByAddingDays:1];
                else
                    aDate = [aDate dateByAddingDays:-1];
            }
        }
**/            
        return aDate;
}

- (NSCalendarDate *) adjustedPeriodicStartDate;
{
    TradeItem *aTradeItem = [self tradeItem];
    TradeOrder *aTradeOrder = [aTradeItem tradeOrder];
    NSCalendarDate *aDate;
    NSString *aFreq = [aTradeOrder cashSettlePrdFreq];

    //aDate = [[[self quoteEndDate] copy] autorelease];
    //Issue 429 -- SEMPRA wants to use accumEndDate
    //aDate = [[[self accumEndDate] copy] autorelease];
    //Issue 6769 -- SEMPRA wants to use nominalEndDate
    aDate = [[[self nominalEndDate] copy] autorelease];

    if (![aFreq isEqualToString:CASH_PERIODIC_FREQ_END_OF_ACCUM]) {
        NSCalendarDate *tmpDate = [aTradeOrder cashSettlePrdStartDate];

        /* try to speed up a little for cases of daily and weekly */
        if ([tmpDate compareWith:aDate]>0) {
            int dayDiff=[aDate timeIntervalSinceDate:tmpDate]/SECONDS_OF_DAY;

            if ([aFreq isEqualToString:CASH_PERIODIC_FREQ_DAILY])
                tmpDate = aDate;
            else if ([aFreq isEqualToString:CASH_PERIODIC_FREQ_WEEKLY]) {
                int weedDiff = dayDiff/7;

                tmpDate = [tmpDate dateByAddingDays:7*weedDiff];
            }
        }

        while ([tmpDate compareWith:aDate]>0) {
            if ([aFreq isEqualToString:CASH_PERIODIC_FREQ_DAILY])
                tmpDate = [tmpDate dateByAddingDays:1];
            else if ([aFreq isEqualToString:CASH_PERIODIC_FREQ_WEEKLY])
                tmpDate = [tmpDate dateByAddingDays:7];
            else if ([aFreq isEqualToString: CASH_PERIODIC_FREQ_QUATERLY])
                tmpDate = [tmpDate dateByAddingYears:0 months:3 days:0
                                                            hours:0 minutes:0 seconds:0];
            else if ([aFreq isEqualToString: CASH_PERIODIC_FREQ_SEMIANNUALY])
                tmpDate = [tmpDate dateByAddingYears:0 months:6 days:0
                                                            hours:0 minutes:0 seconds:0];
            else if ([aFreq isEqualToString: CASH_PERIODIC_FREQ_ANNUALY])
                tmpDate = [tmpDate dateByAddingYears:1 months:0 days:0
                                                            hours:0 minutes:0 seconds:0];
            else  // Default monthly
                tmpDate = [tmpDate dateByAddingYears:0 months:1 days:0
                                                            hours:0 minutes:0 seconds:0];
        }

        aDate = [[tmpDate copy] autorelease];
    }

    return aDate;
}

/**
- (NSCalendarDate *) settlementDateForPaymentTerm:(PaymentTerm *)aPaymentTerm;
{
        TradeItem *aTradeItem = [self tradeItem];
        TradeOrder *aTradeOrder = [aTradeItem tradeOrder];
        NSString *settlementType = [aTradeOrder cashSettleType];
        NSCalendarDate *aDate;
        Calendar *bookingCompCal = [[[[[self tradeItem] bookingCompany] bookingCompanyInfos] firstObject] calendar];
        Calendar *priceCurrCal = [[[self priceCurrency] country] calendar];
        BOOL goForward = YES;

        if ([[aTradeOrder cashSettleHolidays] isEqualToString:@"P"])
            goForward = NO;

        if (!settlementType || [settlementType isEqualToString:CASH_END_OF_CONTRACT_FREQ]) {
            Accumulation *lastAccum = [[aTradeItem accumulations] lastObject];

            if ([self hasTermInFormula])
                aDate = [[[lastAccum quoteEndDate] copy] autorelease];
            else if ([aPaymentTerm useBusinessDate])
                aDate = [[[lastAccum quoteEndDate] copy] autorelease];
            else
                aDate = [[[lastAccum accumEndDate] copy] autorelease];
        } else if ([settlementType isEqualToString:CASH_PERIODIC_FREQ]) 
            aDate = [self adjustedPeriodicStartDateForPaymentTerm:aPaymentTerm];
        else {	// Specific dates
            CashSettleDate *aCs;
                NSEnumerator *e = [[aTradeOrder cashSettleDates] objectEnumerator];
                NSCalendarDate *tmpDate = nil;

                aDate = [[[self quoteEndDate] copy] autorelease];
                while (aCs=[e nextObject]) {

                        if ([aDate compareWith:[aCs cashSettleDate]]>=0 &&
                                        (!tmpDate || [tmpDate compareWith:[aCs cashSettleDate]]<0)) {
                                tmpDate = [aCs cashSettleDate];
                                aDate = [[tmpDate copy] autorelease];
                        }
                }
        }

        if ([aDate isWeekend] && [aPaymentTerm useBusinessDate]) {
            int day=[aDate dayOfWeek];

            if (day==0) {   // sunday
                if ([[aTradeOrder cashSettleSundays] isEqualToString:@"N"])
                    aDate = [aDate dateByAddingDays:1];
                else
                    aDate = [aDate dateByAddingDays:-2];
            } else {  // saturday
                if ([[aTradeOrder cashSettleSaturdays] isEqualToString:@"N"]) //N is next business day, P is previous
                    aDate = [aDate dateByAddingDays:2];
                else
                    aDate = [aDate dateByAddingDays:-1];
            }
        }

        if ( [aPaymentTerm useBusinessDate] && [bookingCompCal isHoliday:aDate] || [priceCurrCal isHoliday:aDate] ) {
            while( [bookingCompCal isHoliday:aDate] || [priceCurrCal isHoliday:aDate] ){
                if (goForward)
                    aDate = [aDate dateByAddingDays:1];
                else
                    aDate = [aDate dateByAddingDays:-1];
            }
        }

        return aDate;
}
***/

- (NSCalendarDate *) adjustedPeriodicStartDateForPaymentTerm:(PaymentTerm *)aPaymentTerm;
{
    TradeItem *aTradeItem = [self tradeItem];
    TradeOrder *aTradeOrder = [aTradeItem tradeOrder];
    NSCalendarDate *aDate=nil;
    NSString *aFreq = [aTradeOrder cashSettlePrdFreq];

    if ([self hasTermInFormula])
        aDate = [[[self quoteEndDate] copy] autorelease];
    else if ([aPaymentTerm useBusinessDate])
        aDate = [[[self quoteEndDate] copy] autorelease];
    else
        aDate = [[[self accumEndDate] copy] autorelease];

    if (![aFreq isEqualToString:CASH_PERIODIC_FREQ_END_OF_ACCUM]) {
        NSCalendarDate *tmpDate = [aTradeOrder cashSettlePrdStartDate];

        /* try to speed up a little for cases of daily and weekly */
        if ([tmpDate compareWith:aDate]>0) {
            int dayDiff=[aDate timeIntervalSinceDate:tmpDate]/SECONDS_OF_DAY;

            if ([aFreq isEqualToString:CASH_PERIODIC_FREQ_DAILY])
                tmpDate = aDate;
            else if ([aFreq isEqualToString:CASH_PERIODIC_FREQ_WEEKLY]) {
                int weedDiff = dayDiff/7;

                tmpDate = [tmpDate dateByAddingDays:7*weedDiff];
            }
        }

        while ([tmpDate compareWith:aDate]>0) {
            if ([aFreq isEqualToString:CASH_PERIODIC_FREQ_DAILY])
                tmpDate = [tmpDate dateByAddingDays:1];
            else if ([aFreq isEqualToString:CASH_PERIODIC_FREQ_WEEKLY])
                tmpDate = [tmpDate dateByAddingDays:7];
            else if ([aFreq isEqualToString: CASH_PERIODIC_FREQ_QUATERLY])
                tmpDate = [tmpDate dateByAddingYears:0 months:3 days:0
                                                            hours:0 minutes:0 seconds:0];
            else if ([aFreq isEqualToString: CASH_PERIODIC_FREQ_SEMIANNUALY])
                tmpDate = [tmpDate dateByAddingYears:0 months:6 days:0
                                                            hours:0 minutes:0 seconds:0];
            else if ([aFreq isEqualToString: CASH_PERIODIC_FREQ_ANNUALY])
                tmpDate = [tmpDate dateByAddingYears:1 months:0 days:0
                                                            hours:0 minutes:0 seconds:0];
            else  // Default monthly
                tmpDate = [tmpDate dateByAddingYears:0 months:1 days:0
                                                            hours:0 minutes:0 seconds:0];
        }

        aDate = [[tmpDate copy] autorelease];
    }

    return aDate;
}

- (BOOL) hasTermInFormula;
{
    BOOL retVal=NO;
    NSEnumerator *qppE = [[self qpps] objectEnumerator],*formulaBodyE=nil;
    QuotePricingPeriod *qpp=nil;
    FormulaBody *aFormulaBody=nil;
    
    while (qpp=[qppE nextObject]){

        formulaBodyE = [[[qpp formula] formulaBodies] objectEnumerator];
        while (aFormulaBody=[formulaBodyE nextObject]) {
            if ([[aFormulaBody rangeType] isEqualToString:FP_RANGE])
                retVal = YES;
            else if ([[aFormulaBody rangeType] isEqualToString:FP_TRIGGER])
                retVal = YES;
            else {
                FormulaComponent *comp = [[aFormulaBody formulaComponents] lastObject];
                FormulaCompPriceTerm *priceTerm = [comp formulaCompPriceTerm];

                if (priceTerm)
                    retVal = YES;
            }
        }
    }

    return retVal;
}

@end
