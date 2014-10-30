<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'id'); ?>
		<?php echo $form->textField($model, 'id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'idinvoice'); ?>
		<?php echo $form->dropDownList($model, 'idinvoice', GxHtml::listDataEx(Invoice::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'idmedical'); ?>
		<?php echo $form->dropDownList($model, 'idmedical', GxHtml::listDataEx(Traitement::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'quantity'); ?>
		<?php echo $form->textField($model, 'quantity'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'price'); ?>
		<?php echo $form->textField($model, 'price'); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
