// Copyright (c) 2011-2014 The TheBurningSavage Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef THEBURNINGSAVAGE_QT_THEBURNINGSAVAGEADDRESSVALIDATOR_H
#define THEBURNINGSAVAGE_QT_THEBURNINGSAVAGEADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class TheBurningSavageAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit TheBurningSavageAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** TheBurningSavage address widget validator, checks for a valid theburningsavage address.
 */
class TheBurningSavageAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit TheBurningSavageAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // THEBURNINGSAVAGE_QT_THEBURNINGSAVAGEADDRESSVALIDATOR_H
