<?php

Yii::import('application.models._base.BaseInvoice');

class Invoice extends BaseInvoice
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}