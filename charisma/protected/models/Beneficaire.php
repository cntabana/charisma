<?php

Yii::import('application.models._base.BaseBeneficaire');

class Beneficaire extends BaseBeneficaire
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}