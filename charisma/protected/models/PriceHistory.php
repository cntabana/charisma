<?php

Yii::import('application.models._base.BasePriceHistory');

class PriceHistory extends BasePriceHistory
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}