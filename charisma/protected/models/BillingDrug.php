<?php

Yii::import('application.models._base.BaseBillingDrug');

class BillingDrug extends BaseBillingDrug
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}