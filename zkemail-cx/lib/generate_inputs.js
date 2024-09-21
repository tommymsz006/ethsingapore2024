const { generateEmailVerifierInputs } = require("@zk-email/helpers");

export async function generateCircuitInputs(rawEmail, inputs) {
    const circuitInputs = await generateEmailVerifierInputs(rawEmail, {
        ignoreBodyHashCheck: true,
        maxBodyLength: 0,
        maxHeaderLength: 1024,
        shaPrecomputeSelector: "",
    });

    const emailBodyString = circuitInputs.emailBody ? Buffer.from(circuitInputs.emailBody.map(Number)).toString('ascii') : null;
    const emailHeaderString = circuitInputs.emailHeader ? Buffer.from(circuitInputs.emailHeader.map(Number)).toString('ascii') : null;
    let regexInputs = {};

    //console.log(emailHeaderString);
    let match;
    
    match = emailHeaderString.match(new RegExp("subject:=\\?UTF-8\\?B\\?WW91ciBlVGlja2V0IGlzIHJlYWR5OiB1c2UgYm9va2luZyByZWYg"));

    //console.log(match[0]);
    if (match) {
        regexInputs = {
            ...regexInputs,
            bookingRefRegexIdx: match.index + match[0].length
        }
    }
    match = null;
    

    const packedInputs = {};

    

    return {
        ...circuitInputs,
        ...regexInputs,
        ...packedInputs
    }
}